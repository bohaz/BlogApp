require 'rails_helper'

RSpec.describe 'Users', type: :feature do
  let!(:users) { create_list(:user, 5) }

  describe 'Users index page' do
    before { visit users_path }

    it 'displays usernames of all users' do
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'displays profile pictures of all users' do
      users.each do |user|
        expect(page).to have_selector("img[src$='#{user.photo}']")
      end
    end

    it 'displays the number of posts each user has written' do
      users.each do |user|
        expect(page).to have_content("Number of posts: #{user.posts.count}")
      end
    end

    it 'redirects to user show page when a user is clicked' do
      first_user = users.first
      click_link first_user.name
      expect(current_path).to eq(user_path(first_user))
    end
  end

  describe 'User show page' do
    let(:user) { create(:user) }
    before { visit user_path(user) }

    it 'displays the user profile picture' do
      expect(page).to have_selector("img[src$='#{user.photo}']")
    end

    it 'displays the user username' do
      expect(page).to have_content(user.name)
    end

    it 'displays the number of posts the user has written' do
      expect(page).to have_content("Number of posts: #{user.posts.count}")
    end

    it 'displays the user bio' do
      expect(page).to have_content(user.bio)
    end

    it 'displays the user first 3 posts' do
      user.recent_posts.each do |post|
        expect(page).to have_content(post.text.truncate(100))
      end
    end

    it 'has a button to view all of the user posts' do
      expect(page).to have_link('See all posts', href: user_posts_path(user))
    end

    it 'redirects to post show page when a post is clicked' do
      post = user.posts.first
      click_link "Post ##{post.id}"
      expect(current_path).to eq(user_post_path(user, post))
    end

    it 'redirects to user post index when "See all posts" is clicked' do
      click_link 'See all posts'
      expect(current_path).to eq(user_posts_path(user))
    end
  end
end
