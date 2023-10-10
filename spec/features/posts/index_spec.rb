# spec/features/posts/index_spec.rb
require 'rails_helper'

RSpec.describe 'Posts Index', type: :feature do
  let!(:user) { create(:user) }
  let!(:posts) { create_list(:post, 5, author: user) }

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
end
