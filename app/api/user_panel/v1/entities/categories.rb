# frozen_string_literal: true

module UserPanel::V1
  module Entities
    class Categories < Grape::Entity
      expose :id
      expose :title
    end
  end
end

