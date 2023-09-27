class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def update_posts_counter
    self.author.posts_counter = self.author.posts.count
    self.author.save
  end
end
