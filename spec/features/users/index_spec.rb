# spec/features/users/index_spec.rb
require 'rails_helper'

RSpec.describe 'Users Index', type: :feature do
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
end
