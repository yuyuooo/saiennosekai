class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.string :title, null: false
      t.string :weather, null: false
      t.text :body, null: false
      t.date :diary_date, null: false
      t.integer :user_id, null: false
      t.integer :crop_folder_id, null: false

      t.timestamps
    end
  end
end
