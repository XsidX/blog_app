require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET #index' do
    before(:example) { get user_posts_path(1) }

    it 'returns a 200 OK status' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    it "contains placeholder text, 'Here is a list of posts for a given user:'" do
      expect(response.body).to include('Here is a list of posts for a given user:')
    end
  end

  describe 'GET #show' do
    before(:example) { get user_post_path(1, 1) }
    it('returns a 200 ok status') do
      expect(response).to have_http_status(:ok)
    end

    it('renders the show template') do
      expect(response).to render_template(:show)
    end

    it("contains placeholder text, 'Showing details for a single post by a given user'") do
      expect(response.body).to include('Showing details for a single post by a given user')
    end
  end
end
