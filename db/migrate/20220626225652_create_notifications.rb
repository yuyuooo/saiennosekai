class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|

      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :crop_folder_id
      t.integer :item_id
      t.integer :crop_comment_id
      t.integer :room_id
      t.integer :chat_id
      t.integer :favorite_id
      t.integer :like_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
