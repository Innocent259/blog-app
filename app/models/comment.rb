class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :post
  belongs_to :user

  after_save :comment_counter

  private

  def comment_counter
    post.increment!(:comments_counter)
  end
end
