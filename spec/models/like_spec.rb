require 'rails_helper'

describe Like, type: :model do
  let(:user) { User.create(name: 'John Doe', posts_counter: 0) }
  let(:post) { user.posts.create(title: 'A valid title') }

  it 'updates the likes_counter after save' do
    expect { post.likes.create(author: user) }.to change { post.reload.likes_counter }.by(1)
  end
end
