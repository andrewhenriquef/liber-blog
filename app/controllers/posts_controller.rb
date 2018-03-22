class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[new edit destroy]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post criado com sucesso!' }
      else
        format.html { render :new, notice: 'Não foi possível criar este post' }
      end
    end
  end

  def edit; end

  def update
    if validate_user(@post.user_id)
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: 'O Post foi atualizado com sucesso!' }
        else
          format.html { render :edit, notice: 'O post não pode ser atualizado!' }
        end
      end
    else
      flash[:user_validation] = "Você não tem autorização para editar este post"
      render :edit
    end
  end

  def destroy
    if validate_user(@post.user_id)
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_path, notice: 'O post foi deletado.' }
        format.json { head :no_content }
      end
    else
      flash[:user_validation] = "Você não tem autorização para remover este post"
      redirect_to @post
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description)
  end

  def set_post
    @post = Post.friendly.find(params[:id])
  end
end
