class LikesController < ApplicationController
  before_action :set_post, only: [:create]
  before_action :set_current_user, only: [:create]
  def create
    if can? :create, Like
      @like = Like.new
      @like.post = @post
      @like.author = current_user
      if @like.save
        redirect_to user_posts_path(@post.author, @post)
      else
        render :new, status: :unprocessable_entity
      end
    else
      flash[:alert] = 'You must be logged in to like a post'
      redirect_to user_session_path
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_current_user
    @current_user = current_user
  end
end
