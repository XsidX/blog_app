class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :update_likes_count

  private

  def update_likes_count
    post.increment!(:likes_count)
  end
end
