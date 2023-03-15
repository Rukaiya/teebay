module UserPanel::V1
  class Products < UserPanel::Base
    resources :products do
      desc 'Fetch all products'
      params do
        use :pagination, per_page: 30
      end
      get do
        products = Product.all
        UserPanel::V1::Entities::Products.represent(paginate(products).order(title: :desc))
      rescue StandardError => e
        Rails.logger.info "Unable to fetch products due to, #{e.full_message}"
        error!('Unable to fetch products', 500)
      end
    end
  end
end
