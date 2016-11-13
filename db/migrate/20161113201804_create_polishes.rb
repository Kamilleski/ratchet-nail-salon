class CreatePolishes < ActiveRecord::Migration
  def change
    create_table :polishes do |t|
      t.string :brand_name, null: false
      t.string :color_name, null: false
      t.integer :brand_number, null: false
      t.integer :upc, null: false
      t.string :color_group, null: false
      t.string :type, null: false

      t.timestamps null: false
    end
  end
end
