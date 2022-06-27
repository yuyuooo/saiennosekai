class CreateCropFolders < ActiveRecord::Migration[6.1]
  def change
    create_table :crop_folders do |t|
      t.string :crop_name, null: false
      t.string :place, null: false
      t.text :memo, null: false
      t.date :new_crop_date, null: false
      t.integer :user_id, null: false
      t.boolean :is_active, default: true, null: false
      t.boolean :is_published_flag, default: true, null: false

      t.timestamps
    end
  end
end
