class Public::FollowsController < ApplicationController
  before_action :authenticate_user!
  layout 'public/application'

  def create
    @user=User.find(params[:used_id])
    current_user.follow(@user.id)
    #redirect_back(fallback_location: root_path)
  end

  def destroy
    @user=User.find(params[:used_id])
    current_user.unfollow(@user.id)
    #redirect_back(fallback_location: root_path)
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
