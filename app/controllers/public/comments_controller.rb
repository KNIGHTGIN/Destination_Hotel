class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.save
    @post = @comment.post
    @new_comment = Comment.new
    @comments = @post.comments
      #redirect_back(fallback_location: root_path)
    #else
      #redirect_to posts_path
    #end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comments = @post.comments
    @new_comment = Comment.new
    @comment.destroy

    #if   admin_signed_in?
      #redirect_to admin_posts_path
    #else
      #redirect_back(fallback_location: root_path)
    #end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end

end
