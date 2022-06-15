class AddColumnPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :user_id, :integer
    add_column :posts, :tag_id, :integer
    add_column :posts, :hotel_name, :string
    add_column :posts, :text, :text
    add_column :posts, :likes_count, :integer
  end
end
