class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def update_likes_counter
    self.post.likes_counter = self.post.likes.count
    self.post.save
  end
end
