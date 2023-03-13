class CreateUserProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :user_products do |t|
      t.integer :exchange_type, default: 0
      t.integer :option_type, default: 0
      t.datetime :from_date
      t.datetime :to_date
      t.references :product, null: false
      t.references :user, null: false
      t.timestamps
    end
  end
end
