class UserProduct < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :authorization_key, as: :authable

  enum exchange_type: { buy: 0, rent: 1 }

  def check_availability
    return false if (rent? && to_date.to_date <= Date.today) || buy?
  end
end
