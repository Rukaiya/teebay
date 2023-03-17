class AddUserToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :created_by_id, :integer
  end
end
