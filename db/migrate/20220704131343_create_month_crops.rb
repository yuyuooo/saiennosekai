class CreateMonthCrops < ActiveRecord::Migration[6.1]
  def change
    create_table :month_crops do |t|

      t.string :month, null: false
      t.string :crop_name, null: false
      t.string :harvest_time, null: false
      t.text :introduction, null: false
      t.text :method, null: false
      t.boolean :is_published_flag, default: false, null: false

      t.timestamps
    end
  end
end
