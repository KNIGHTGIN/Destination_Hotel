class AddDetailsToPostTags < ActiveRecord::Migration[6.1]
  def create
    add_column :post_tags, :post, :string, foreign_key: true
    add_column :post_tags, :tag, :string, foreign_key: true
  end
end
