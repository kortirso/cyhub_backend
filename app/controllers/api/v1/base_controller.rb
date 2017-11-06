module Api
    module V1
        class BaseController < ApplicationController
            protect_from_forgery with: :null_session, if: -> { request.format.json? }
            before_action :authenticate

            private

            def authenticate
                @user = User.find_by(email: params[:email])
                user_creation if @user.nil?
                check_user_activity
                render json: { error: 'Unauthorized' }, status: 401 unless @user.valid_password?(params[:password])
            end

            def user_creation
                @user = User.new email: params[:email], password: params[:password], active: true
                render json: { error: 'User creation error' }, status: 401 unless @user.save
            end

            def check_user_activity
                render json: { error: 'User is not actives' }, status: 401 unless @user.active?
            end
        end
    end
end
