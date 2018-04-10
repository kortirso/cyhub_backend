module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session, if: -> { request.format.json? }
      before_action :authenticate

      private def authenticate
        @user = User.find_by(email: params[:email])
        user_creation if @user.nil?
        render json: { error: 'Unauthorized' }, status: 401 unless @user.valid_password?(params[:password])
      end

      private def user_creation
        @user = User.new email: params[:email], password: params[:password]
        render json: { error: 'User creation error' }, status: 401 unless @user.save
      end
    end
  end
end
