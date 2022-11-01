class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_user, only: %i[index show]
  before_action :set_current_user, only: %i[index new edit destroy]
  before_action :set_users, only: %i[show index new edit]
  def index
    @pagy, @posts = pagy(@user.posts.order(created_at: :desc).includes(:author), items: 2)
    @posts = @posts.includes(:author)
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = 'Your post was created successfully'
      redirect_to user_posts_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.author == current_user
      if @post.update(post_params)
        flash[:notice] = 'Your post was updated successfully'
        redirect_to user_posts_path(current_user)
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash[:notice] = 'You can only edit your own posts'
      redirect_to user_posts_path(@user)
    end
  end

  def destroy
    if @post.author == current_user
      @post.destroy
      flash[:notice] = 'Your post was deleted successfully'
    else
      flash[:notice] = 'You can only delete your own posts'
    end
    redirect_to user_posts_path(current_user)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_users
    @users = User.all
  end

  def set_current_user
    @current_user = current_user
  end

  def post_params
    # strong parameters, whitelisting
    params.require(:post).permit(:title, :text)
  end
end
