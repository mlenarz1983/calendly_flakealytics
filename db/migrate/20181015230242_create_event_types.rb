class CreateEventTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :event_types do |t|
      t.primary_key :id
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
