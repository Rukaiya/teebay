# frozen_string_literal: true

module UserPanel::V1::Helpers
  module ResponseHelpers
    extend Grape::API::Helpers
    def success_response(msg, status_code)
      {
        status_code:,
        message: msg
      }
    end
  end
end
