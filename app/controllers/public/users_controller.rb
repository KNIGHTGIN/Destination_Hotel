class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  layout 'public/application'

  def show
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(member_params)
      flash[:notice] = "会員情報を更新しました"
      redirect_to members_my_page_path
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
  end

  private
  def member_params
    params.require(:user).permit(:name, :email, :is_deleted)
  end

end
