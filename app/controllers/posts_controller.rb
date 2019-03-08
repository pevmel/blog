class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:show]

  def index
    redirect_to categories_url
  end
  def show
  end

  def new
    @post = Post.new
    @post.category_id = params[:category_id]
  end

  def edit
  end

  def create
    @post = Post.create(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post
      flash[:success] = 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if current_user.is_admin? || @post.user == current_user
      if @post.update(post_params)
        redirect_to @post
        flash[:success] =  'Post was successfully updated.'
      else
        render :edit
      end
    else
      redirect_to category_path(@post.category)
      flash[:alert] = "You can't change the Post which you didn't create."
    end
  end

  def destroy
    if current_user.is_admin? || @post.user == current_user
      @post.destroy
      redirect_to category_path(@post.category)
      flash[:success] =  'Post was successfully destroyed.'
    else
      redirect_to category_path(@post.category)
      flash[:alert] = "You can't delete the Post which you didn't create."
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:name, :content, :file, :category_id)
    end
end
