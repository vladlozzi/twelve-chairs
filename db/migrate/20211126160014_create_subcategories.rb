class CreateSubcategories < ActiveRecord::Migration[6.1]
  def change
    create_table :subcategories do |t|
      t.string :subcategory, null: false
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :subcategories, :subcategory, unique: true
  end
end
