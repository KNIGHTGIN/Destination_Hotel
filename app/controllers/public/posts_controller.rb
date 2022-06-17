class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  layout 'public/application'

  def index
    @post = Post.last
    @posts = Post.page(params[:page]).per(10)
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end

  def new
    @post = Post.new
    @tags = Tag.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_tag(tag_list)
      flash[:notice] = "投稿を保存しました"
      redirect_to post_path(@post)
    else
      render:new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list=params[:post][:name].split(',')
    if @post.update(post_params)
      @post.save_tag(tag_list)
      flash[:notice] = "投稿を更新しました"
      redirect_to post_path(@post.id)
    else
      render:edit
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
    params.require(:post).permit(:hotel_name, :text, :user_id, :tag_id, :name, post_images_images: [])
  end

end
