class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :tag_id
      t.string :hotel_name
      t.text :text
      t.integer :likes_count

      t.timestamps
    end
  end
end
