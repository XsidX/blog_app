class Api::V1::PostsController < ApiController
  before_action :set_user, only: [:index]
  before_action :set_post, only: [:show]
  def index
    @posts = @user.posts.includes(:author)
    render json: @posts, status: 200, include: %i[comments author]
  end

  def show
    render json: @post, status: 200, include: %i[comments author]
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

end
