# frozen_string_literal: true

module UserPanel::V1
  class MyProducts < UserPanel::Base
    resources :my_products do
      desc 'MY Product List'
      params do
        use :pagination, per_page: 30
      end
      get do
        products = Product.current_user_product(@current_user)
        UserPanel::V1::Entities::Products.represent(paginate(products).order(title: :desc))
      rescue StandardError => e
        Rails.logger.info "Unable to fetch user products due to, #{e.full_message}"
        error!('Unable to fetch user products', HTTP_CODE[:INTERNAL_SERVER_ERROR])
      end

      desc 'MY Product Create'
      params do
        requires :title, type: String
        requires :description, type: String
        requires :purchase_price, type: Float
        requires :rent_price, type: Float
        requires :rent_charge_type, type: String, values: %w[hourly daily]
        requires :product_categories_attributes, type: Array do
          requires :category_id, type: Integer
        end
      end
      post do
        product = Product.find_by(title: params[:title], created_by_id: @current_user.id)
        error!('Product already exist with same title', HTTP_CODE[:NOT_ACCEPTABLE]) if product.present?
        params.merge!(created_by_id: @current_user.id)
        Product.create!(params)
        success_response('Successfully created', HTTP_CODE[:CREATED])
      rescue StandardError => e
        Rails.logger.info "Unable to create product due to, #{e.full_message}"
        error!('Unable to create product', HTTP_CODE[:INTERNAL_SERVER_ERROR])
      end

      route_param :id do
        desc 'Update My Product'
        params do
          requires :title, type: String
          requires :description, type: String
          requires :purchase_price, type: Float
          requires :rent_price, type: Float
          requires :rent_charge_type, type: String, values: %w[hourly daily]
        end
        put do
          product = Product.current_user_product(@current_user).find_by(id: params[:id])
          error!('Not Found', HTTP_CODE[:NOT_FOUND]) unless product.present?
          product.update!(params)
          success_response('Successfully updated', HTTP_CODE[:OK])
        rescue StandardError => e
          Rails.logger.info "Unable to update product due to, #{e.full_message}"
          error!('Unable to update product', HTTP_CODE[:INTERNAL_SERVER_ERROR])
        end

      end
    end
  end
end
