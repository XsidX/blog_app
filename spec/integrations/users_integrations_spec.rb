require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe '#users index' do
    before(:example) do
      user1 = User.create(id: 1, name: 'Brad', photo: 'https://randomuser.me/api/portraits/men/65.jpg',
                          bio: 'I am user 1')
      User.create(id: 2, name: 'Sid', photo: 'https://randomuser.me/api/portraits/women/44.jpg', bio: 'I am user 2')
      Post.create(author: user1, title: 'Post 1', text: 'Text 1')
      Post.create(author: user1, title: 'Post 1', text: 'Text 1')

      visit users_path
    end

    it 'displays all user names' do
      expect(page).to have_content('Brad')
      expect(page).to have_content('Sid')
    end

    it 'displays profile picture of each user' do
      expect(page).to have_css('img')
    end

    it 'displays the no. of posts a user has written' do
      expect(page).to have_content('Number of posts: 2')
      expect(page).to have_content('Number of posts: 0')
    end

    it 'redirects to user show page when user is clicked' do
      click_link('Brad profile')
      expect(page).to have_current_path(user_path(1))
    end
  end

  describe '#user show' do
    before(:example) do
      @user1 = User.create(id: 1, name: 'Brad', photo: 'https://randomuser.me/api/portraits/men/65.jpg',
                           bio: 'I am user 1')
      @post1 = Post.create(id: 1, author: @user1, title: 'Post 1', text: 'Text 1', created_at: Time.now - 1.day)
      @post2 = Post.create(id: 2, author: @user1, title: 'Post 2', text: 'Text 2', created_at: Time.now - 2.days)
      @post3 = Post.create(id: 3, author: @user1, title: 'Post 3', text: 'Text 3', created_at: Time.now - 3.days)
      @post4 = Post.create(id: 4, author: @user1, title: 'Post 4', text: 'Text 4', created_at: Time.now - 4.days)

      visit user_path(1)
    end

    it 'displays the user profile picture' do
      expect(page).to have_css('img')
    end

    it 'displays user name' do
      expect(page).to have_content('Brad')
    end

    it 'displays the no. of posts a user has written' do
      expect(page).to have_content('Number of posts: 4')
    end

    it 'displays user bio' do
      expect(page).to have_content('I am user 1')
    end

    it 'displays the users first 3 posts' do
      expect(page).to have_content('Post 1')
      expect(page).to have_content('Post 2')
      expect(page).to have_content('Post 3')
      expect(page).not_to have_content('Post 4')
    end

    it 'displays a button to see all posts' do
      expect(page).to have_link('See all posts')
    end

    it 'redirects to the users posts index page when see all posts is clicked' do
      click_link('See all posts')
      expect(page).to have_current_path(user_posts_path(1))
    end
  end

  context '#user show click' do
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
end
