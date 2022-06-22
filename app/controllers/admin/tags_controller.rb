class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin/application'

  def index
    @tag_list =Tag.all
  end

  def destroy
    current_user.update(is_deleted: true)
    reset_session
    flash[:notice] = "削除しました"
    redirect_to admin_tag_path
  end

  private
  def post_params
    params.require(:tag).permit(:user_id, :tag_id, :is_deleted)
  end

end
