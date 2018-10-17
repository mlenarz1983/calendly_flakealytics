class CreateEventTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :event_types do |t|
      t.belongs_to :user, index: true
      t.integer :user_id
      t.string :name
      t.string :external_id, index: true
      t.timestamps
    end

    add_foreign_key :event_types, :users
  end
end
