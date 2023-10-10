# spec/features/posts/show_spec.rb
require 'rails_helper'

RSpec.describe 'Posts Show', type: :feature do
  let!(:user) { create(:user) }
  let!(:post_with_comments_and_likes) do
    post = create(:post, author: user, title: 'Expected Post Title')
    create_list(:comment, 3, post:, author: user)
    create_list(:like, 3, post:, author: user)
    post
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
  end
end
