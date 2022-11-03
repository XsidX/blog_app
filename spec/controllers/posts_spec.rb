require 'rails_helper'

RSpec.describe PostsController, type: :request do
  before(:example) do
    @user = User.create(name: 'John Doe', id: 1)
    @post = Post.create(author: @user, title: 'Post 1', text: 'random text', id: 1)
  end
  describe 'GET #index' do
    before(:example) { get user_posts_path(1) }

    it 'returns a 200 OK status' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    it "contains placeholder text, 'Number of posts:'" do
      expect(response.body).to include('Number of posts:')
    end
  end

  describe 'GET #show' do
    before(:example) { get user_post_path(@user, @post) }
    it('returns a 200 ok status') do
      expect(response).to have_http_status(:ok)
    end

    it('renders the show template') do
      expect(response).to render_template(:show)
    end

    it("contains placeholder text, 'Back'") do
      expect(response.body).to include('Back')
    end
  end
end
