class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_posts_counter
  after_destroy :decrease_user_posts_counter
  after_initialize :set_default

  def update_posts_counter
    author.increment!(:posts_counter)
  end

  def decrease_user_posts_counter
    author.decrement!(:posts_counter)
  end

  def recent_five_comments
    comments.order(created_at: :desc).limit(5)
  end
end
