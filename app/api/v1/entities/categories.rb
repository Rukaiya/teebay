module Api
  module V1
    module Entities
      class Categories < Grape::Entity
        expose :id
        expose :title
      end
    end
  end
end
