module Api
  module V1
    class PositionsController < Api::V1::BaseController
      skip_before_action :verify_authenticity_token, only: %i[create]
      before_action :check_member, only: %i[create]
      before_action :find_product, only: %i[create]

      def create
        @user.member.basket.add_product(@product)
        render json: @user, status: 200
      end

      private def check_member
        render json: { error: 'User does not have membership' }, status: 404 unless @user.member?
      end

      private def find_product
        @product = Product.find_by(id: params[:position][:product_id])
        render json: { error: 'Product does not exist' }, status: 404 if @product.nil?
      end
    end
  end
end
