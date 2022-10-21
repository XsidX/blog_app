require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'associations' do
    it('belongs to user') do
      post = Post.reflect_on_association(:author)
      association = post.macro
      expect(association).to eq(:belongs_to)
    end

    it('has many comments') do
      post = Post.reflect_on_association(:comments)
      association = post.macro
      expect(association).to eq(:has_many)
    end

    it('has many likes') do
      post = Post.reflect_on_association(:likes)
      association = post.macro
      expect(association).to eq(:has_many)
    end
  end

  context 'validate title' do
    it('validates presence of title') do
      post = Post.new(title: nil)
      post.valid?
      expect(post.errors[:title]).to include("can't be blank")
    end

    it('validates length of title') do
      post = Post.new(title: 'a' * 251)
      post.valid?
      expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
    end
  end

  context 'validate likes and comments' do
    it('validates numericality of comments_count') do
      post = Post.new(comments_count: 'a')
      post.valid?
      expect(post.errors[:comments_count]).to include('is not a number')
    end

    it('validates numericality of likes_count') do
      post = Post.new(likes_count: 'a')
      post.valid?
      expect(post.errors[:likes_count]).to include('is not a number')
    end

    it('validates that comments_count is greater than or equal to 0') do
      post = Post.new(comments_count: -1)
      post.valid?
      expect(post.errors[:comments_count]).to include('must be greater than or equal to 0')
    end

    it('validates that likes_count is greater than or equal to 0') do
      post = Post.new(likes_count: -1)
      post.valid?
      expect(post.errors[:likes_count]).to include('must be greater than or equal to 0')
    end

    it('validates that comments_count is an integer') do
      post = Post.new(comments_count: 1.5)
      post.valid?
      expect(post.errors[:comments_count]).to include('must be an integer')
    end

    it('validates that likes_count is an integer') do
      post = Post.new(likes_count: 1.5)
      post.valid?
      expect(post.errors[:likes_count]).to include('must be an integer')
    end
  end

  context 'methods' do
    it('returns recent posts') do
      # Create a user, a post and 6 comments
      user = User.new(name: 'John Doe')
      post = Post.new(author: user, title: 'Post 1', text: 'random text')
      6.times do |i|
        Comment.new(post:, text: "Comment #{i}")
      end

      result = post.recent_comments
      expect(result).to eq(post.comments.order(created_at: :desc).limit(5))
    end
  end
end
