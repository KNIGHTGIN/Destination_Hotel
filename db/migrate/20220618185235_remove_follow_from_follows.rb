class RemoveFollowFromFollows < ActiveRecord::Migration[6.1]
  def change
    remove_column :follows, :follower_id, :integer
    remove_column :follows, :followed_id, :integer
  end
end
