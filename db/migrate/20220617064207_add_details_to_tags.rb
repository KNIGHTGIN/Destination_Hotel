class AddDetailsToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :name, :string
    add_column :tags, :tag_id, :integer
  end
end
