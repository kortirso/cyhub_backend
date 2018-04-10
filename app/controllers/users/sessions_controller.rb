module Users
  class SessionsController < Devise::SessionsController
    skip_before_action :verify_authenticity_token, only: %i[create destroy]
  end
end
