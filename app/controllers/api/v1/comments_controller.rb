class Api::V1::CommentsController < ApiController
  before_action :set_post, only: %i[index create]
  def index
    @comments = @post.comments
    render json: @comments, status: 200, include: %i[post author]
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.author = current_user
    if @comment.save
      render json: @comment, status: 200, include: %i[post author]
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
