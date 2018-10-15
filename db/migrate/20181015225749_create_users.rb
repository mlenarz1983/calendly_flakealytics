class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.primary_key :id
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.string :avatar_url
      t.string :calendly_token

      t.timestamps
    end
  end
end
