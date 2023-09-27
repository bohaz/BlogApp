class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  private

  def update_comments_counter
    post.comments_counter = post.comments.count
    post.save
  end
end
