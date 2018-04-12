RSpec.describe Users::RegistrationsController, type: :controller do
  it { should_not use_before_action :verify_authenticity_token }
end
