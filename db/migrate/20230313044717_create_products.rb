class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :purchase_price, default: 0
      t.decimal :rent_price, default: 0
      t.references :category, null: false
      t.timestamps
    end
  end
end
