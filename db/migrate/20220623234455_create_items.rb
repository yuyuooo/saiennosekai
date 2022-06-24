class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      
      t.integer :user_id, null: false
      t.string :item_name, null: false
      t.integer :item_count, null: false
      t.string :sales_method, null: false
      t.string :sales_area, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.boolean :is_active, default: true, null: false

      t.timestamps
    end
  end
end
