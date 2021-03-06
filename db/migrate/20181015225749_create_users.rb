class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email_address
      t.string :first_name
      t.string :last_name
      t.string :avatar_url
      t.string :api_key
      t.string :external_id, index: true

      t.timestamps
    end
  end
end
