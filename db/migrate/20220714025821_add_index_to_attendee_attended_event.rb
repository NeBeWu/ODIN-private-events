class AddIndexToAttendeeAttendedEvent < ActiveRecord::Migration[7.0]
  def change
    change_table :attendances do |t|
      t.index %i[attendee_id attended_event_id], unique: true
    end
  end
end
