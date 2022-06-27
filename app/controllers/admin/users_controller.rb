class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin/application'

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "会員情報を更新しました"
      redirect_to admin_user_path(@user)
    else
      flash[:alert] = "会員情報の更新に失敗しました"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :hotel_name, :is_deleted)
  end

end
