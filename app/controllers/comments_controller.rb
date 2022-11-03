class CommentsController < ApplicationController
  before_action :set_post, only: %i[new create]
  before_action :set_user, only: %i[new create]
  before_action :set_comment, only: [:destroy]

  def new
    @comment = Comment.new
  end

  def create
    if can? :create, Comment
      @comment = Comment.new(comment_params)
      @comment.post = @post
      @comment.author = current_user
      if @comment.save
        redirect_to user_posts_path(@post.author, @post)
      else
        redirect_to user_posts_path(@post.author, @post), status: :unprocessable_entity
      end
    else
      flash[:alert] = 'You must be logged in to create a comment'
      redirect_to user_session_path
    end
  end

  def destroy
    if can? :destroy, Comment
      @comment.destroy
      flash[:notice] = 'Comment was deleted successfully'
    else
      flash[:notice] = 'You are not authorized to delete this comment'
    end
    redirect_to user_posts_path(@comment.post.author, @comment.post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
