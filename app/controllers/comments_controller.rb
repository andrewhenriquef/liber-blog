class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)

    if @comment.errors.any?
      flash[:comment_errors] = @comment.errors.full_messages
    end
    redirect_to @post
  end

  def destroy
    @comment = Comment.find(params[:format])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
