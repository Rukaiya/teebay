class User < ApplicationRecord
  has_many :user_products
  has_many :products, through: :user_products

  validates :first_name, :last_name, :email, :phone, presence: true
  validates :password, confirmation: true, presence: true, on: create
  validates :phone, length: { is: 11 }, uniqueness: true
end
