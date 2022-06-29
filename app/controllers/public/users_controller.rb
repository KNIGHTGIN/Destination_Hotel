class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  layout 'public/application'

  def my_page
    @user = User.where(id: current_user.id).eager_load(:posts, :likes)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to users_my_page_path
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    current_user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def likes
    @user = User.find(params[:id])
    @posts = @user.liked_posts
  end

  def hotels
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :posts, :likes, :comments, :hotel_name, :text, :is_deleted)
  end

end
