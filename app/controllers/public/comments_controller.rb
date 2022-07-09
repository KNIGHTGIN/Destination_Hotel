class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.save
      #redirect_back(fallback_location: root_path)
    #else
      #redirect_to posts_path
    #end
  end

  def destroy
    Comment.find(params[:id]).destroy
    if   admin_signed_in?
      redirect_to admin_posts_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end

end
