class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def update_comments_counter
    self.post.comments_counter = self.post.comments.count
    self.post.save
  end
end
