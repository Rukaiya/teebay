class Product < ApplicationRecord
  belongs_to :user, foreign_key: :created_by_id
  has_one :user_product
  has_many :product_categories, dependent: :restrict_with_error
  accepts_nested_attributes_for :product_categories, reject_if: :all_blank, allow_destroy: true

  validates_presence_of :title, :purchase_price, :rent_price

  enum rent_charge_type: { hourly: 0, daily: 1 }

  def self.current_user_product(current_user)
    Product.where(created_by_id: current_user.id)
  end
end
