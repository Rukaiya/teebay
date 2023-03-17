module UserPanel::V1
  class Products < UserPanel::Base
    resources :products do
      desc 'Fetch all products'
      params do
        use :pagination, per_page: 30
        optional :title, type: String
        optional :category_id, type: Integer
        optional :exchange_type, type: String, values: %w[buy rent]
      end
      get do
        products = Product.all
        products = products.where('LOWER(title) LIKE :key', key: params[:title].downcase) if params[:title].present?
        products = products.where('rent_price > 0') if params[:exchange_type].present? && params[:exchange_type] == 'rent'
        UserPanel::V1::Entities::Products.represent(paginate(products).order(title: :desc))
      rescue StandardError => e
        Rails.logger.info "Unable to fetch products due to, #{e.full_message}"
        error!('Unable to fetch products', HTTP_CODE[:INTERNAL_SERVER_ERROR])
      end

      route_param :id do
        desc 'Product Details'
        get do
          product = Product.find_by(id: params[:id])
          error!('Not Found', HTTP_CODE[:NOT_FOUND]) unless product.present?
          UserPanel::V1::Entities::Products.represent(product)
        rescue StandardError => e
          Rails.logger.info "Unable to fetch product details due to, #{e.full_message}"
          error!('Unable to fetch product details', HTTP_CODE[:INTERNAL_SERVER_ERROR])
        end

        desc 'Buy Product'
        post '/buy' do
          product = Product.find_by(id: params[:id])
          error!('Not Found', HTTP_CODE[:NOT_FOUND]) unless product.present?
          check_availability = UserProduct.where(product_id: params[:id]).last.check_product_availability
          error!('Product not available', HTTP_CODE[:NOT_ACCEPTABLE]) unless check_availability

          UserProduct.create!(user_id: @current_user.id, product_id: params[:id])
          success_response('Successfully bought', HTTP_CODE[:OK])
        rescue StandardError => e
          Rails.logger.info "Unable to buy product due to, #{e.full_message}"
          error!('Unable to buy product', HTTP_CODE[:INTERNAL_SERVER_ERROR])
        end

        desc 'Rent Product'
        params do
          requires :from_date, type: Date
          requires :to_date, type: Date
        end
        post '/rent' do
          product = Product.find_by(id: params[:id])
          error!('Not Found', HTTP_CODE[:NOT_FOUND]) unless product.present?
          check_availability = UserProduct.where(product_id: params[:id]).last.check_product_availability
          error!('Product not available', HTTP_CODE[:NOT_ACCEPTABLE]) unless check_availability
          UserProduct.create!(user_id: @current_user.id,
                              product_id: params[:id],
                              exchange_type: :rent,
                              from_date: params[:from_date],
                              to_date: params[:to_date])
          success_response('Successfully rented', HTTP_CODE[:OK])
        rescue StandardError => e
          Rails.logger.info "Unable to rent product due to, #{e.full_message}"
          error!('Unable to rent product', HTTP_CODE[:INTERNAL_SERVER_ERROR])
        end
      end
    end
  end
end
