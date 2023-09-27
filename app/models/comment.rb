class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def update_comments_counter
    post.comments_counter = post.comments.count
    post.save
  end
end
