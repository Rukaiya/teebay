module UserPanel::V1
  class Categories < UserPanel::Base
    resources :categories do
      desc 'Fetch all categories'
      params do
        use :pagination, per_page: 30
      end
      get do
        categories = Category.all
        UserPanel::V1::Entities::Categories.represent(paginate(categories).order(title: :asc))
      rescue StandardError => e
        Rails.logger.info "Unable to fetch categories due to, #{e.full_message}"
        error!('Unable to fetch categories', 500)
      end
    end
  end
end
