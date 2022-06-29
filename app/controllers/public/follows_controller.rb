class Public::FollowsController < ApplicationController
  before_action :authenticate_user!
  layout 'public/application'

  def create
    current_user.follow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  def following
    user = User.find(params[:user_id])
    @followers = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @followings = user.followers
  end

end
