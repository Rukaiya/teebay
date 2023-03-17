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
      end
    end
  end
end
