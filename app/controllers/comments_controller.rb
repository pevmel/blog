class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if !comment.content.blank? && comment.save
      CommentChannel.broadcast_to "comment_channel",
                          com_model_name: comment.supplier_type.downcase,
                          com_model_id: comment.supplier_id.to_s,
                          mod_comment: comment_render(comment)
    else
      redirect_to category_path(params[:comment][:supplier_id]) if params[:comment][:supplier_type] == "Category"
      redirect_to posts_path(params[:comment][:supplier_id]) if params[:comment][:supplier_type] == "Post"
      flash[:danger] = "Your comment can't be empty."
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :supplier_type, :supplier_id)
    end

    def comment_render(comment)
      self.class.render(partial: "comments/comment", locals: {comment: comment})
    end
end
