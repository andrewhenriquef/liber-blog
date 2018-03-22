class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create edit destroy]

  def create
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.create(comment_params.merge!(user_id: current_user.id))

    if @comment.errors.any?
      flash[:comment_errors] = @comment.errors.full_messages
    end
    redirect_to @post
  end

  def edit
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.find(params[:format])
  end

  def destroy
    @post = Post.friendly.find(params[:post_id])
    @comment = @post.comments.find(params[:format])
    @comment.destroy
    redirect_to @post
  end

  def update
    @post = Post.friendly.find(params[:post_id])
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
