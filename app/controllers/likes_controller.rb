class LikesController < ApplicationController
  before_action :set_post, only: [:create]
  before_action :set_current_user, only: [:create]
  def create
    @like = Like.new
    @like.post = @post
    @like.author = current_user
    if @like.save
      redirect_to user_posts_path(@post.author, @post)
    else
      render :new, status: :unprocessable_entity
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



