# frozen_string_literal: true

module UserPanel::V1
  module Entities
    class Products < Grape::Entity
      expose :id
      expose :title
      expose :description
      expose :purchase_price
      expose :rent_price
      expose :rent_charge_type
      expose :created_at
    end
  end
end

