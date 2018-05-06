module Api
  module V1
    class PositionsController < Api::V1::BaseController
      skip_before_action :verify_authenticity_token, only: %i[create]
      before_action :check_member, only: %i[create]
      before_action :find_product, only: %i[create]

      def create
        Position.create(product: @product, basket: @user.member.basket)
        render json: @user.member.basket, status: 200
      end

      private def check_member
        render json: { error: 'User does not have membership' }, status: 404 unless @user.member?
      end

      private def find_product
        @product = Product.find_by(id: params[:product_id])
        render json: { error: 'Product does not exist' }, status: 404 if @product.nil?
      end
    end
  end
end
