class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @categories = Category.all
  end

  def show
    @posts = Post.where(category: params[:id])
    @comment = Comment.new
    @comment.supplier_type = "Category"
    @comment.supplier_id = params[:id]
    @comments = Comment.where(supplier_type: "Category", supplier_id: params[:id])
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    category = Category.new(category_params)
    category.user = current_user
    if category.save
      redirect_to category
      flash[:success] = "Category was successfully created."
    else
      render :new
    end
  end

  def update
    if current_user.is_admin? || @category.user == current_user
      if @category.update(category_params)
        redirect_to @category
        flash[:success] =  'Category was successfully updated.'
      else
        render :edit
      end
    else
      redirect_to categories_url
      flash[:alert] = "You can't change the Category which you didn't create."
    end
  end

  def destroy
    if @category.posts.count > 0
      redirect_to categories_url
      flash[:alert] = "You can delete only a Category which does not contain any Posts."
    else
      if current_user.is_admin? || @category.user == current_user
        @category.destroy
        redirect_to categories_url
        flash[:success] = 'Category was successfully destroyed.'
      else
        redirect_to categories_url
        flash[:alert] = "You can't delete the Category which you didn't create."
      end
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :description)
    end
end
