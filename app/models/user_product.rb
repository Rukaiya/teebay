class UserProduct < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :authorization_key, as: :authable

  enum exchange_type: { buy: 0, rent: 1 }

  # validates_presence_of :from_date, :to_date, if: exchange_type.rent?
end
