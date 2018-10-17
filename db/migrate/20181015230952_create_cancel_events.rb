class CreateCancelEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :cancel_events do |t|
      t.belongs_to :event_type, index: true
      # t.belongs_to :user, index: true
      # t.integer :user_id
      t.integer :event_type_id
      t.string :invitee_name
      t.string :invitee_email
      t.string :reason
      t.string :external_id, index: true

      t.timestamps     
    end

    add_foreign_key :cancel_events, :event_types
    # add_foreign_key :cancel_events, :users
  end
end
