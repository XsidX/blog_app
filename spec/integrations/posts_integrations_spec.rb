require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe '#posts index' do
    before(:example) do
      @user1 = User.create(id: 1, name: 'Brad', photo: 'https://randomuser.me/api/portraits/men/65.jpg',
                           bio: 'I am user 1')
      @post1 = Post.create(id: 1, author: @user1, title: 'Post 1',
                           text: 'Line one. Line two. Line three, Line four. Line five', created_at: Time.now - 1.day)
      Post.create(id: 2, author: @user1, title: 'Post 2', text: 'text 2', created_at: Time.now - 1.day)
      Post.create(id: 3, author: @user1, title: 'Post 3', text: 'text 3', created_at: Time.now - 2.day)
      Post.create(id: 4, author: @user1, title: 'Post 4', text: 'text 4', created_at: Time.now - 3.day)

      6.times do |i|
        Comment.create(id: i + 1, author: @user1, post: @post1, text: "Comment #{i + 1}",
                       created_at: Time.now - (i + 1).day)
      end

      2.times do |i|
        Like.create(id: i + 1, author: @user1, post: @post1)
      end

      visit user_posts_path(1)
    end

    it 'displays the users profile picture' do
      expect(page).to have_css('img')
    end

    it 'displays the users name' do
      expect(page).to have_content('Brad')
    end

    it 'displays the number of posts the user has written' do
      expect(page).to have_content('Number of posts: 4')
    end

    it 'displays the posts title' do
      expect(page).to have_content('Post 1')
    end

    it 'displays some of the posts body' do
      expect(page).to have_content('Line one. Line two.')
      expect(page).not_to have_content('Line three, Line four. Line five')
    end

    it 'displays the recent 5 comments of each post' do
      expect(page).to have_content('Comment 1')
      expect(page).to have_content('Comment 2')
      expect(page).to have_content('Comment 3')
      expect(page).to have_content('Comment 4')
      expect(page).to have_content('Comment 5')
      expect(page).not_to have_content('Comment 6')
    end

    it 'displays the number of comments each post has' do
      expect(page).to have_content('View 6 previous comments')
    end

    it 'displays the number of likes each post has' do
      expect(page).to have_content('2')
    end

    it 'has pagination if there are more posts than fit the view' do
      click_link('Next')
      expect(page).to have_content('Post 3')
      expect(page).to have_content('Post 4')

      expect(page).not_to have_content('Post 1')
      expect(page).not_to have_content('Post 2')
    end
  end

  context '#posts index click' do
    before(:example) do
      @user1 = User.create(id: 1, name: 'Brad', photo: 'https://randomuser.me/api/portraits/men/65.jpg',
                           bio: 'I am user 1')
      @post1 = Post.create(id: 1, author: @user1, title: 'Post 1', text: 'Text 1', created_at: Time.now - 1.day)
      visit user_path(1)
    end

    it 'redirects to a posts show page when clicked' do
      click_link('Continue reading')
      expect(page).to have_current_path(user_post_path(1, 1))
    end
  end

  describe '#posts show' do
    before(:example) do
      @user1 = User.create(id: 1, name: 'Brad', photo: 'https://randomuser.me/api/portraits/men/65.jpg',
                           bio: 'I am user 1')
      @post1 = Post.create(id: 1, author: @user1, title: 'Post 1', text: 'Hello world')
      6.times do |i|
        Comment.create(id: i + 1, author: @user1, post: @post1, text: 'Comment 1')
      end

      2.times do |i|
        Like.create(id: i + 1, author: @user1, post: @post1)
      end

      visit user_post_path(1, 1)
    end

    it 'displays the posts title' do
      expect(page).to have_content('Post 1')
    end

    it 'displays who wrote the post' do
      expect(page).to have_content('Post 1 #1, by Brad')
    end

    it 'displays the number of likes the post has' do
      expect(page).to have_content('Likes: 2')
    end

    it 'displays the posts body' do
      expect(page).to have_content('Hello world')
    end

    it 'displays the username of the author of each comment' do
      expect(page).to have_content('Brad: Comment 1')
    end

    it 'displays each comment made' do
      expect(page).to have_content('Comment 1')
    end
  end
end
