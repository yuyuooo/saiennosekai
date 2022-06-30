class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.text :action, null: false
      t.datetime :start_time, null: false
      t.integer :user_id, null: false
      t.integer :crop_folder_id, null: false

      t.timestamps
    end
  end
end
