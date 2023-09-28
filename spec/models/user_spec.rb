require 'rails_helper'
describe User, type: :model do
  it 'is not valid without a name' do
    user = User.new(name: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid with a negative posts_counter' do
    user = User.new(name: 'John Doe', posts_counter: -1)
    expect(user).to_not be_valid
  end

  it 'returns the three most recent posts' do
    user = User.create(name: 'John Doe', posts_counter: 0)
    oldest_post = user.posts.create(title: 'Old Post', created_at: 5.days.ago)

    post1 = user.posts.create(title: 'Recent Post 1', created_at: 1.day.ago)
    post2 = user.posts.create(title: 'Recent Post 2', created_at: 2.days.ago)
    post3 = user.posts.create(title: 'Recent Post 3', created_at: 3.days.ago)
    recent_posts = [post1, post2, post3]

    expect(user.recent_posts).to match_array(recent_posts)
    expect(user.recent_posts).not_to include(oldest_post)
  end
end
