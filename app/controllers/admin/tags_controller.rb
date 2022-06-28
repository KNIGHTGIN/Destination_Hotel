class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin/application'

  def index
    @tag_list =Tag.all
  end

  private
  def post_params
    params.require(:tag).permit(:user_id, :tag_id)
  end

end
