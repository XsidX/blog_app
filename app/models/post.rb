class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, :text, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_count, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_count, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  after_create :increment_posts_count
  after_destroy :decrement_posts_count

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def increment_posts_count
    author.increment!(:posts_count)
  end

  def decrement_posts_count
    author.decrement!(:posts_count)
  end
end
