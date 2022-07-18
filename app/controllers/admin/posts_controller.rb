class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin/application'


  def index
    #@post = Post.last
    @posts = Post.page(params[:page]).per(10)
    @tag_list =Tag.all
    #@post_tags = @post.tags
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @like = Like.new
    @comments = @post.comments
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    if params[:post][:post_image_id]
      params[:post][:post_image_id].each do |post_image_id|
        image = @post.post_images.find(post_image_id)
        image.destroy
      end
    end
    tag_list=params[:post][:name].split(',')
    if @post.update(post_params)
      image_tags = @post.post_images.flat_map do |post_image|
        #それぞれの画像のデータをとりタグ付け
        Vision.get_image_data(post_image.image)
      end
      @post.save_tag(tag_list, image_tags)
      flash[:notice] = "投稿を更新しました"
      redirect_to admin_post_path(@post.id)
    else
      render:edit
    end
  end

  def destroy
    if @post = Post.find(params[:id]).destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to admin_posts_path
    else
      redirect_to "/", notice: "投稿を削除できませんでした"
    end
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.page(params[:page]).per(10)
  end

  private
  def post_params
    params.require(:post).permit(:hotel_name, :text, :user_id, :tag_id, :name, :body, :star, :list, post_images_images: [])
  end

end
