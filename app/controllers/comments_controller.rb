class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)

    if @comment.errors.any?
      flash[:comment_errors] = @comment.errors.full_messages
    end
    redirect_to @post
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:format])
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:format])
    @comment.destroy
    redirect_to @post
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.body = params[:body]
    if @comment.save
      redirect_to @post
    else
      flash[:comment_errors] = @comment.errors.full_messages
      redirect_to edit_post_comments_path(@post, @comment)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:id, :body)
  end
end
