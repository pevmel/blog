class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to category_path(params[:comment][:supplier_id]) if params[:comment][:supplier_type] == "Category"
      redirect_to posts_path(params[:comment][:supplier_id]) if params[:comment][:supplier_type] == "Post"
    else
      redirect_to root_path
      flash[:danger] = "You didn't make a comment"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :supplier_type, :supplier_id)
    end
end
