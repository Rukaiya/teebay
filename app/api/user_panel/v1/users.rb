# frozen_string_literal: true

module UserPanel::V1
  class Users < UserPanel::Base
    resources :users do
      desc 'User Login'
      params do
        requires :email, type: String
        requires :password, type: String
      end
      route_setting :authentication, optional: true
      post :login do
        user = User.find_by(email: params[:email])
        error!('Unauthorized', HTTP_CODE[:UNAUTHORIZED]) unless user.present?
        AuthToken.generate_access_token(user) if user.password == params[:password]
      rescue StandardError => e
        Rails.logger.info("Failed to login due to -#{e.full_message}")
        error!('Failed to login', HTTP_CODE[:INTERNAL_SERVER_ERROR])
      end

      desc 'User Logout'
      delete :logout do
        error!('Not Found', HTTP_CODE[:NOT_FOUND]) unless AuthToken.remove_access_token(@current_user)
        success_response('Successfully logged out', HTTP_CODE[:OK])

      rescue StandardError => e
        Rails.logger.info("Failed to logout due to: #{e.full_message}")
        error!("Failed to logout due to: #{e.full_message}", HTTP_CODE[:INTERNAL_SERVER_ERROR])
      end

      desc 'User SignUp'
      params do
        requires :first_name, type: String
        requires :last_name, type: String
        requires :email, type: String
        requires :phone, type: String
        requires :address, type: String
        requires :password, type: String
        requires :password_confirmation, type: String
      end
      route_setting :authentication, optional: true
      post :signup do
        error!('Email already exists', HTTP_CODE[:NOT_ACCEPTABLE]) if User.find_by(email: params[:email]).present?
        error!('Phone number already exists', HTTP_CODE[:NOT_ACCEPTABLE]) if User.find_by(phone: params[:phone]).present?
        error!('Password cannot be blank', HTTP_CODE[:NOT_ACCEPTABLE]) if params[:password].blank?
        error!('Password didn\'t match', HTTP_CODE[:NOT_ACCEPTABLE]) if params[:password] != params[:password_confirmation]
        User.create!(params)
        success_response('Successfully created', HTTP_CODE[:CREATED])
      rescue StandardError => e
        Rails.logger.info("Failed to signup due to -#{e.full_message}")
        error!('Failed to signup', HTTP_CODE[:INTERNAL_SERVER_ERROR])
      end
    end
  end
end
