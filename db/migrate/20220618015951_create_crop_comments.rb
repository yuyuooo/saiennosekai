class CreateCropComments < ActiveRecord::Migration[6.1]
  def change
    create_table :crop_comments do |t|
      t.text :comment, null: false
      t.integer :user_id, null: false
      t.integer :crop_folder_id, null: false

      t.timestamps
    end
  end
end
