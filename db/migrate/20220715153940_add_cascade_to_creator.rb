class AddCascadeToCreator < ActiveRecord::Migration[7.0]
  def up
    remove_foreign_key :events, :users, column: :creator_id
    add_foreign_key :events, :users, column: :creator_id, on_delete: :cascade
  end

  def down
    remove_foreign_key :events, :users, column: :creator_id
    add_foreign_key :events, :users, column: :creator_id
  end
end
