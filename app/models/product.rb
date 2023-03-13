class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates_presence_of :title, :purchase_price, :rent_price
end
