class CreateCropFolders < ActiveRecord::Migration[6.1]
  def change
    create_table :crop_folders do |t|
      t.string :crop_name
      t.string :place
      t.text :memo
      t.date :new_crop_date
      t.integer :user_id

      t.timestamps
    end
  end
end
