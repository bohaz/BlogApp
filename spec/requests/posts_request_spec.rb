require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0) }

  describe 'GET /index' do
    it 'returns http success' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      post = user.posts.create(title: 'A valid title')
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Here is a single post for a given user')
    end
  end
end
