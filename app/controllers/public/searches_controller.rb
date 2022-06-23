class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  layout 'public/application'

  def  search_result
    @range = params[:range]
    if @range == "ユーザー名"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end
end
