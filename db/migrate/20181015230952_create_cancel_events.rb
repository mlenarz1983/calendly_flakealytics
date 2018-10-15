class CreateCancelEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :cancel_events do |t|
      t.integer :user_id
      t.integer :event_type_id
      t.string :invitee_name
      t.string :invitee_email
      t.string :reason

      t.timestamps
    end
  end
end
