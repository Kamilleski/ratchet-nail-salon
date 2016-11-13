class CreatePolishes < ActiveRecord::Migration
  def change
    create_table :polishes do |t|
      t.string :brand_name, null: false
      t.string :color_name, null: false
      t.integer :brand_number, null: false
      t.string :upc, null: false
      t.string :color_group, null: false
      t.string :polish_type, null: false
      t.string :hex_color, null: false
      t.string :description, null: false
      t.string :image_url, null: false

      t.timestamps null: false
    end
  end
end
