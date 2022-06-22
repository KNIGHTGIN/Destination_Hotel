class AddColumnToLikes < ActiveRecord::Migration[6.1]
  def change
    add_column :likes, :follower_id, :integer
    add_column :likes, :followed_id, :integer
  end
end
