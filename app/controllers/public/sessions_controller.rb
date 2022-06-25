# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  layout 'public/application'

  def guest_sign_in
    user = User.guest
    sign_in user   # ユーザーをログインさせる
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

    def reject_user
      @user = User.find_by(email: params[:user][:email])
      if @user
        if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true)
          flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
          redirect_to new_user_registration_path
        else
          flash[:alert] = "項目を入力してください"
        end
      end
    end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
