require 'rails_helper'

RSpec.describe User, type: :model do
  context 'associations' do
    it('has many posts') do
      user = User.reflect_on_association(:posts)
      association = user.macro
      expect(association).to eq(:has_many)
    end

    it('has many comments') do
      user = User.reflect_on_association(:comments)
      association = user.macro
      expect(association).to eq(:has_many)
    end

    it('has many likes') do
      user = User.reflect_on_association(:likes)
      association = user.macro
      expect(association).to eq(:has_many)
    end
  end

  context 'validations' do
    it('validates presence of name') do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it('validates numericality of posts_count') do
      user = User.new(posts_count: 'abc')
      user.valid?
      expect(user.errors[:posts_count]).to include('is not a number')
    end

    it('validates that posts_count is greater than or equal to 0') do
      user = User.new(posts_count: -1)
      user.valid?
      expect(user.errors[:posts_count]).to include('must be greater than or equal to 0')
    end
  end

  context 'methods' do
    it('returns recent posts') do
      # Create a user and 5 posts
      user = User.new(name: 'John Doe')
      5.times do |i|
        Post.new(author: user, title: "Post #{i}", text: 'random text')
      end

      result = user.recent_posts
      expect(result).to eq(user.posts.order(created_at: :desc).limit(3))
    end
  end
end
