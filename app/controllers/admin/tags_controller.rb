class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin/application'

  def index
    @tag_list = Tag.all
  end

  def edit
    @tag_list = Tag.all
  end

  def destroy_all
    id_list = []
      params[:tags].each{|key, hash|
      hash.each{|key, ids|
        id_list.append(ids.first)
      }
    }
    PostTag.where(tag_id: id_list).delete_all
    Tag.delete(id_list)
    flash[:notice] = "タグを削除しました"
    redirect_to admin_tags_path
  end

  private
  def post_params
    params.require(:tag).permit(:user_id, :tag_id)
  end

end
