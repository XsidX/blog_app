require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe '#users index' do
    before(:example) do
      user1 = User.create(id: 1, name: 'Brad', photo: 'https://randomuser.me/api/portraits/men/65.jpg', bio: 'I am user 1')
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
   

end
