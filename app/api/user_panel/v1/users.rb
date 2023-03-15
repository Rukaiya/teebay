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
        error!("Failed to login due to -#{e.full_message}", 500)
      end

      desc 'User Logout'
      delete :logout do
        error!('Not Found', HTTP_CODE[:NOT_FOUND]) unless AuthToken.remove_access_token(@current_user)
        {
          message: 'Successfully logged out',
          status_code: HTTP_CODE[:OK]
        }
      rescue StandardError => e
        Rails.logger.info("Failed to logout due to: #{e.full_message}")
        error!("Failed to logout due to: #{e.full_message}", 500)
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
        {
          status_code: 201,
          message: 'Successfully created'
        }
      rescue StandardError => e
        Rails.logger.info("Failed to signup due to -#{e.full_message}")
        error!("Failed to signup due to -#{e.full_message}", 500)
      end
    end
  end
end
