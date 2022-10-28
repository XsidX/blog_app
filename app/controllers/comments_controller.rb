class CommentsController < ApplicationController
  before_action :set_post, only: %i[new create]
  before_action :set_current_user, only: %i[new create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.author = current_user
    if @comment.save
      redirect_to user_posts_path(@post.author, @post)
    else
      redirect_to user_posts_path(@post.author, @post), status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_current_user
    @current_user = current_user
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
