require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'associations' do
    it('belongs to user') do
      like = Like.reflect_on_association(:author)
      association = like.macro
      expect(association).to eq(:belongs_to)
    end

    it('belongs to post') do
      like = Like.reflect_on_association(:post)
      association = like.macro
      expect(association).to eq(:belongs_to)
    end
  end

  context 'methods' do
    it('updates likes_count') do
      # Create a user, post and 3 likes
      user = User.new(name: 'John Doe')
      post = Post.new(author: user, title: 'Lorem Ipsum', text: 'Lorem Ipsum')
      Like.create(author: user, post:)
      Like.create(author: user, post:)
      Like.create(author: user, post:)

      result = post.likes_count
      expect(result).to eq(3)
    end
  end
end
