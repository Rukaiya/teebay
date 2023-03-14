class AddChargeTypeInProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :rent_charge_type, :integer, default: 0
    remove_column :user_products, :option_type
  end
end
