class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :crop_title
      t.text :action
      t.datetime :start_time
      t.integer :user_id
      t.integer :crop_folder_id

      t.timestamps
    end
  end
end
