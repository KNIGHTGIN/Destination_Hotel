class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  layout 'public/application'

  def index
    @post = Post.last
    @posts = Post.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @tags = Tag.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:notice] = "投稿を保存しました"
      redirect_to post_path(@post)
    else
      @tags = Tag.all
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tags = Tag.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿を更新しました"
      redirect_to post_path(@post)
    else
      @tags = Tag.all
      render :edit
    end
  end

  def destroy
    if @post = Post.find(params[:id]).destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to post_path
    else
      flash[:notice] = "投稿を削除できませんでした"
      redirect_to post_path
    end
  end

  private
  def post_params
    params.require(:post).permit(:hotel_name, :text, :user_id, :tag_id, post_images_images: [])
  end

end
