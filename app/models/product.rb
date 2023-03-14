class Product < ApplicationRecord
  has_many :user_products, dependent: :restrict_with_error
  has_many :users, through: :user_products
  has_many :product_categories, dependent: :restrict_with_error
  accepts_nested_attributes_for :product_categories, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :title, :purchase_price, :rent_price

  enum rent_charge_type: {hourly: 0, daily: 1}
end
