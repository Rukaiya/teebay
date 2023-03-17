module UserPanel::V1
  class UserProducts < UserPanel::Base
    resources :user_products do
      desc 'Fetch all user products'
      params do
        use :pagination, per_page: 30
      end
      get do
        user_products = @current_user.user_products.all
        UserPanel::V1::Entities::UserProducts.represent(paginate(user_products).order(title: :desc))
      rescue StandardError => e
        Rails.logger.info "Unable to fetch user products due to, #{e.full_message}"
        error!('Unable to fetch user products', HTTP_CODE[:INTERNAL_SERVER_ERROR])
      end

      route_param :id do
        desc 'Product Delete'
        delete do
          product = Product.current_user_product(@current_user).find_by(id: params[:id])
          error!('Not Found', HTTP_CODE[:NOT_FOUND]) unless product.present?
          product.destroy!
          success_response('Successfully deleted', HTTP_CODE[:OK])
        rescue StandardError => e
          Rails.logger.info "Unable to fetch product details due to, #{e.full_message}"
          error!('Unable to fetch product details', HTTP_CODE[:INTERNAL_SERVER_ERROR])
        end
      end
    end
  end
end
