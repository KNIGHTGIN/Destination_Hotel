class AddColumnsToFollows < ActiveRecord::Migration[6.1]
  def change
    add_reference :follows, :user, null: false, foreign_key: true
    add_reference :follows, :follow, null: false, foreign_key: true
  end
end
