require 'rails_helper'

describe Comment, type: :model do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0) }
  let(:post) { user.posts.create(title: 'A valid title') }

  it 'updates the comments_counter after save' do
    expect { post.comments.create(author: user, text: 'A comment') }.to change { post.reload.comments_counter }.by(1)
  end
end
