class User < ApplicationRecord
  include BCrypt
  has_many :user_products
  has_many :products, through: :user_products

  validates :first_name, :last_name, :email, :phone, presence: true
  validates :password, confirmation: true, presence: true, on: create
  validates :phone, length: { is: 11 }, uniqueness: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
