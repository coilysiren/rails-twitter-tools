class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :user_id
      t.string :encrypted_user_key
      t.string :encrypted_user_secret
      t.string :target_id
      t.datetime :unmute_when

      t.timestamps null: false
    end
  end
end
