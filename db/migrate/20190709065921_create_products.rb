class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :stock
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.decimal :price, precision: 5, scale: 2

      t.timestamps
    end
  end
end
