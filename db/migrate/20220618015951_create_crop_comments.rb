class CreateCropComments < ActiveRecord::Migration[6.1]
  def change
    create_table :crop_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :crop_folder_id

      t.timestamps
    end
  end
end
