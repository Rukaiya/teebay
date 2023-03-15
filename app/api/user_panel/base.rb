# frozen_string_literal: true

module UserPanel
  class Base < Grape::API
    include Grape::Kaminari
    # Contains all the constant that will be used for development
    include Constants

    #############################
    # Prefix and Formatting
    #############################
    version 'v1', using: :path
    format :json
    prefix :api
    formatter :json, Grape::Formatter::Json

    #############################
    # Authorization
    #############################
    before do
      ActiveStorage::Current.host = request.base_url
      auth_optional = route&.settings&.dig(:authentication, :optional)
      if auth_optional
        # allow users if the endpoint specifies so
        Rails.logger.info 'Authentication optional for this endpoint'
      else
        error!('Unauthorized', HTTP_CODE[:UNAUTHORIZED]) unless authenticated!
      end
    end

    helpers do
      def authenticated!
        auth_key = AuthorizationKey.find_by(token: bearer_token)
        if auth_key.present? && !auth_key.expired?
          @current_user = auth_key.authable
        else
          error!('Unauthorized', HTTP_CODE[:UNAUTHORIZED])
        end
      rescue StandardError => e
        Rails.logger.error "Authentication failed due to: #{e.message}"
        error!('Unauthorized', HTTP_CODE[:UNAUTHORIZED])
      end

      def bearer_token
        request.headers.fetch('Authorization', '').split(' ').last
      end
    end

    #############################
    # API Mounts with Grape
    #############################
    mount V1::Categories
    mount V1::Products
    mount V1::Users
  end
end

