class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create edit destroy]
  before_action :set_post
  before_action :set_comment, only: :update
  before_action :set_comment_with_post, only: %i[edit destroy]

  def create
    @comment = @post.comments.create(comment_params.merge!(user_id: current_user.id))

    if @comment.errors.any?
      flash[:comment_errors] = @comment.errors.full_messages
    end
    redirect_to @post
  end

  def edit
    unless validate_user(@comment.user_id)
      flash[:user_validation] = 'Você não tem autorização para editar este comentario'
      redirect_to @post
    end
  end

  def destroy
    if validate_user(@comment.user_id)
      @comment.destroy
    else
      flash[:user_validation] = 'Você não tem autorização para remover este comentario'
    end
    redirect_to @post
  end

  def update
    if validate_user(@comment.user_id)
      if @comment.update(body: params[:body])
        redirect_to @post
      else
        flash[:comment_errors] = @comment.errors.full_messages
        redirect_to edit_post_comments_path(@post, @comment)
      end
    else
      flash[:user_validation] = 'Você não tem autorização para editar este comentario'
      redirect_to edit_post_comments_path(@post, @comment)
    end
  end

  private

  def set_post
    @post = Post.friendly.find(params[:post_id])
  end

  def set_comment_with_post
    @comment = @post.comments.find(params[:format])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:id, :body)
  end
end
