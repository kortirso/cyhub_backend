module Users
  class RegistrationsController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token
  end
end
