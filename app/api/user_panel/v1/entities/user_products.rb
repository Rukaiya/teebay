# frozen_string_literal: true

module UserPanel::V1
  module Entities
    class UserProducts < Grape::Entity
      expose :id
      expose :exchange_type
      expose :created_at
      expose :from_date
      expose :to_date
      expose :product, with: UserPanel::V1::Entities::Products
    end
  end
end

