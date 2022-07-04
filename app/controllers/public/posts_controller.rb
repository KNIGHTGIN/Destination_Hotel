class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :search_tag]
  layout 'public/application'

  def index
    #@post = Post.last
    @posts = Post.page(params[:page]).per(10)
    @tag_list=Tag.all
    #@post_tags = @post.tags
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @like = Like.new
    @comments = @post.comments  #投稿詳細に関連付けてあるコメントを全取得
    @comment = current_user.comments.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:name].split(',')
    if @post.save

      # tags = Vision.get_image_data(@post.image)
      # tags.each do |tag|
      #   list.tags.create(name: tag)
      # end
      #複数投稿画像のためそれぞれの情報が必要
      @post.post_images.each do |post_image|
        #それぞれの画像のデータをとりタグ付け
        image_tags = Vision.get_image_data(post_image.image)
        #image_tagsが揃うとtag_listへ保存
        tag_list += image_tags
      end
      #uniqをつけタグのダブりをなくす
      @post.save_tag(tag_list.uniq)

      flash[:notice] = "投稿を保存しました"
      redirect_to posts_path
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
      @post.post_images.each do |post_image|
        #それぞれの画像のデータをとりタグ付け
        image_tags = Vision.get_image_data(post_image.image)
        #image_tagsが揃うとtag_listへ保存
        tag_list += image_tags
      end
      @post.save_tag(tag_list)
      flash[:notice] = "投稿を更新しました"
      redirect_to post_path(@post.id)
    else
      render:edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    return unless post.user_id == current_user.id

    post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.page(params[:page]).per(10)
  end

  private
  def post_params
    params.require(:post).permit(:hotel_name, :text, :user_id, :tag_id, :name, :body, :list, post_images_images: [])
  end

end
