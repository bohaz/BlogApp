# spec/features/user_posts_spec.rb
require 'rails_helper'

RSpec.describe 'User Posts', type: :feature do
  let!(:user) { create(:user) }
  let!(:posts) { create_list(:post, 5, author: user) }
  # Creando algunos comentarios y 'likes' para un post.
  let!(:post_with_comments_and_likes) do
    post = create(:post, author: user, title: 'Expected Post Title')
    create_list(:comment, 3, post:, author: user)
    create_list(:like, 3, post:, author: user)
    post
  end

  describe 'User post index page' do
    before { visit user_posts_path(user) }

    it 'displays the title of each post' do
      user.posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end

    it 'displays the user profile picture' do
      expect(page).to have_selector("img[src$='#{user.photo}']")
    end

    it 'displays the user username' do
      expect(page).to have_content(user.name)
    end

    it 'displays the number of posts the user has written' do
      expect(page).to have_content("Number of posts: #{user.posts.count}")
    end

    it 'displays some of the post body' do
      posts.each do |post|
        expect(page).to have_content(post.text.truncate(100))
      end
    end

    it 'displays how many comments a post has' do
      expect(page).to have_content("Comments: #{post_with_comments_and_likes.comments.count}")
    end

    it 'displays how many likes a post has' do
      expect(page).to have_content("Likes: #{post_with_comments_and_likes.likes.count}")
    end

    it 'shows pagination if more posts than fit on view' do
      expect(page).to have_selector('.pagination')
    end

    it 'redirects to post show page when a post is clicked' do
      first_post = posts.first
      click_link first_post.title
      expect(current_path).to eq(user_post_path(user, first_post))
    end
  end

  describe 'Post show page' do
    before { visit user_post_path(user, post_with_comments_and_likes) }

    it 'displays the first comments on a post' do
      post_with_comments_and_likes.comments.first(3).each do |comment|
        expect(page).to have_content(comment.text)
      end
    end

    it 'displays the post title' do
      expect(page).to have_content("Post ##{post_with_comments_and_likes.id}")
    end

    it 'displays the post author' do
      expect(page).to have_content(post_with_comments_and_likes.author.name)
    end

    it 'displays how many comments the post has' do
      expect(page).to have_content(post_with_comments_and_likes.comments.count)
    end

    it 'displays the username of each commentor' do
      post_with_comments_and_likes.comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end

    it 'displays the comment each commentor left' do
      post_with_comments_and_likes.comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end

    it 'displays how many likes the post has' do
      expect(page).to have_content(post_with_comments_and_likes.likes.count)
    end

    it 'displays the post body' do
      expect(page).to have_content(post_with_comments_and_likes.text)
    end

    it 'displays the username of each commentor' do
      post_with_comments_and_likes.comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end

    it 'displays the comment each commentor left' do
      post_with_comments_and_likes.comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end
