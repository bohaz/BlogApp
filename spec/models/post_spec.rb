require 'rails_helper'

describe Post, type: :model do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0) }

  it 'is not valid without a title' do
    post = Post.new(title: nil, author: user)
    expect(post).to_not be_valid
  end

  it 'is not valid with a title longer than 250 characters' do
    post = Post.new(title: 'A' * 251, author: user)
    expect(post).to_not be_valid
  end

  it 'returns the five most recent comments' do
    post = user.posts.create(title: 'A valid title')
    oldest_comment = post.comments.create(author: user, text: 'Old Comment', created_at: 5.days.ago)

    comment1 = post.comments.create(author: user, text: 'Recent Comment 1', created_at: 1.day.ago)
    comment2 = post.comments.create(author: user, text: 'Recent Comment 2', created_at: 2.days.ago)
    comment3 = post.comments.create(author: user, text: 'Recent Comment 3', created_at: 3.days.ago)
    comment4 = post.comments.create(author: user, text: 'Recent Comment 4', created_at: 4.days.ago)
    comment5 = post.comments.create(author: user, text: 'Recent Comment 5', created_at: Time.now)
    recent_comments = [comment1, comment2, comment3, comment4, comment5]

    expect(post.recent_comments).to match_array(recent_comments)
    expect(post.recent_comments).not_to include(oldest_comment)
  end
end
