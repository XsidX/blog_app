class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :text, presence: true

  after_save :update_comments_count

  private

  def update_comments_count
    post.increment!(:comments_count)
  end
end
