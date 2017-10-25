module Api
    module V1
        class BaseController < ApplicationController
            protect_from_forgery with: :null_session, if: -> { request.format.json? }
            before_action :authenticate

            private

            def authenticate
                @user = User.active.find_by(email: params[:email])
                render json: { error: 'Unauthorized' }, status: 401 if @user.nil? || !@user.valid_password?(params[:password])
            end
        end
    end
end
