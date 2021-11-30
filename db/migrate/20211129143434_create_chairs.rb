class CreateChairs < ActiveRecord::Migration[6.1]
  def change
    create_table :chairs do |t|
      t.references :subcategory, null: false, foreign_key: true
      t.string :chair
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
    add_index :chairs, :chair, unique: true
    add_index :chairs, :price
  end
end
