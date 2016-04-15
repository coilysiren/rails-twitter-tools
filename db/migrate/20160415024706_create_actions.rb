class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.string :target
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
