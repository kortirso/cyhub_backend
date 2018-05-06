module Api
  module V1
    class ProductsController < Api::V1::BaseController
      skip_before_action :authenticate

      def index
        render json: { products: ActiveModel::Serializer::CollectionSerializer.new(Product.all, each_serializer: ProductSerializer) }, status: 200
      end
    end
  end
end
