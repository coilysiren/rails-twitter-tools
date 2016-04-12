class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :encrypted_user_key
      t.string :encrypted_user_secret
      t.string :user_name
      t.string :user_picture

      t.timestamps null: false
    end
  end
end
