class CreateInvitations < ActiveRecord::Migration[7.0]
  def change
    create_table :invitations do |t|
      t.references :invited_event, null: false, foreign_key: { to_table: :events }
      t.references :invitee, null: false, foreign_key: { to_table: :users, on_delete: :cascade }
      t.index %i[invitee_id invited_event_id], unique: true

      t.timestamps
    end
  end
end
