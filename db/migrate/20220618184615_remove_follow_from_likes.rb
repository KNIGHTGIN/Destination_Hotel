class RemoveFollowFromLikes < ActiveRecord::Migration[6.1]
  def change
    remove_column :likes, :follower_id, :integer
    remove_column :likes, :followed_id, :integer
  end
end
