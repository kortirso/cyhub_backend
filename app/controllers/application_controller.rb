class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    rescue_from ActionController::RoutingError, with: :render_not_found
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    def catch_404
        raise ActionController::RoutingError.new(params[:path]), 'route error'
    end

    private

    def render_not_found
        render template: 'shared/404', status: 404
    end

    def user_is_admin?
        redirect_to root_path unless current_user.admin?
    end
end
