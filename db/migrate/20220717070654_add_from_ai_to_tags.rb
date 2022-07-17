class AddFromAiToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :from_ai, :boolean, null: false, default: false
  end
end
