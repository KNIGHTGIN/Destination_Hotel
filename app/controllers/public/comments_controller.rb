class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_back(fallback_location: root_path)  #コメント送信後は、一つ前のページへリダイレクトさせる。
    else
      redirect_back(fallback_location: root_path)  #同上
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to posts_path
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end

end
