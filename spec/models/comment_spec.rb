require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'associations' do
    it('belongs to user') do
      comment = Comment.reflect_on_association(:author)
      association = comment.macro
      expect(association).to eq(:belongs_to)
    end

    it('belongs to post') do
      comment = Comment.reflect_on_association(:post)
      association = comment.macro
      expect(association).to eq(:belongs_to)
    end
  end

  context 'methods' do
    it('updates comments_count') do
      # Create a user, post and 3 comments
      user = User.new(name: 'John Doe')
      post = Post.new(author: user, title: 'Lorem Ipsum', text: 'Lorem Ipsum')
      Comment.create(author: user, post:, text: 'Random text1')
      Comment.create(author: user, post:, text: 'Random text2')
      Comment.create(author: user, post:, text: 'Random text3')

      result = post.comments_count
      expect(result).to eq(3)
    end
  end
end
