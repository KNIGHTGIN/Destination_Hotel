class Admin::PostsController < ApplicationController


  def index
    @post = Post.last
    @posts = Post.page(params[:page]).per(10)
  end

  def show
    set_post(params[:id])
  end

  def edit
    set_post(params[:id])
  end

  def update
    set_post(params{:id})
    if @post.update(article_params)
      redirect_to admin_post_path(@post.id), notice: "編集しました"
    else
      render "edit"
    end
  end

  def destroy
    if @post = Post.find(params[:id]).destroy
      redirect_to admin_posts_path, notice: "削除しました"
    else
      redirect_to "/", notice: "エラーが発生しました"
    end
  end

  private
  def post_params
    params.require(:post).permit(:hotel_name, :text, :user_id, post_images_images: [])
  end

end
