module Api
    module V1
        class UsersController < Api::V1::BaseController
            def me
                render json: @user, status: 200
            end
        end
    end
end
