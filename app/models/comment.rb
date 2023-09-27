class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post

  private

  def update_comments_counter
    post.comments_counter = post.comments.count
    post.save
  end
end
