class AddCascadeToAttendee < ActiveRecord::Migration[7.0]
  def up
    remove_foreign_key :attendances, :users, column: :attendee_id
    add_foreign_key :attendances, :users, column: :attendee_id, on_delete: :cascade
  end

  def down
    remove_foreign_key :attendances, :users, column: :attendee_id
    add_foreign_key :attendances, :users, column: :attendee_id
  end
end
