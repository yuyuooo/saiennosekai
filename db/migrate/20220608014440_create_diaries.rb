class CreateDiaries < ActiveRecord::Migration[6.1]
  def change
    create_table :diaries do |t|
      t.string :title
      t.string :weather
      t.text :body
      t.date :diary_date
      t.integer :user_id
      t.integer :crop_folder_id

      t.timestamps
    end
  end
end
