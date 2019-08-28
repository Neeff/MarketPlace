class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :shop_id
      t.references :product, null: false, foreign_key: true
      t.decimal :total, precision: 5, scale: 2
      t.boolean :paid, default: false
      t.string :stripe_charge

      t.timestamps
    end
  end
end
