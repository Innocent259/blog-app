class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :like_counter

  private

  def like_counter
    post.increment!(:likes_counter)
  end
end
