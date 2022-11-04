class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_post, only: %i[show edit update destroy]
  before_action :set_user, only: %i[show index new create destroy edit update]
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
    if can? :create, Post
      @post = @user.posts.new(post_params)
      @post.author = current_user
      if @post.save
        flash[:notice] = 'Post was created successfully'
        redirect_to user_posts_path(@post.author)
      else
        render :new, status: :unprocessable_entity
      end
    else
      flash[:alert] = 'You must be logged in to create a post'
      redirect_to user_session_path
    end
  end

  def edit
    if can? :edit, Post
      render :edit
    else
      flash[:alert] = 'You are not authorized to edit this post'
      redirect_to user_posts_path(@user)
    end
  end

  def update
    if can? :update, Post
      if @post.update(post_params)
        flash[:notice] = 'Post was updated successfully'
        redirect_to user_posts_path(@post.author)
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash[:notice] = 'You are not authorized to edit this post'
      redirect_to user_posts_path(@user)
    end
  end

  def destroy
    if can? :destroy, Post
      @post.destroy
      flash[:notice] = 'Post was deleted successfully'
    else
      flash[:notice] = 'You are not authorized to delete this post'
    end
    redirect_to user_posts_path(@user)
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
