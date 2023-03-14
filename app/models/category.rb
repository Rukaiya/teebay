class Category < ApplicationRecord
  has_many :product_categories
  has_many :products, through: :product_categories

  validates_presence_of :title
end
