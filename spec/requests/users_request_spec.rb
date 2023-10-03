require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users'
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Here is a list of all users')
    end
  end

  describe 'GET /show' do
    let(:user) { User.create(name: 'John Doe', posts_counter: 0) }

    it 'returns http success' do
      get "/users/#{user.id}"
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Here is a single user')
    end
  end
end
