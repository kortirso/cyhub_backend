class AdminsController < ApplicationController
    before_action :authenticate_user!
    before_action :user_is_admin?

    def index; end
end
