# Macros for testing omniauth controllers
module OmniauthMacros
  def facebook_hash
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      'provider' => 'facebook',
      'uid' => '123545',
      'credentials' => {
        'token' => '1234567890'
      },
      'info' => {
        'email' => 'example_facebook@xyze.it',
        'name' => 'Alberto Pellizzon',
        'first_name' => 'Alberto',
        'last_name' => 'Pellizzon',
        'image' => ''
      },
      'extra' => {
        'raw_info' => {}
      }
    )
  end

  def facebook_invalid_hash
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      'provider' => 'facebook',
      'uid' => '123545',
      'credentials' => {
        'token' => '1234567890'
      },
      'info' => {
        'name' => 'Alberto Pellizzon',
        'first_name' => 'Alberto',
        'last_name' => 'Pellizzon',
        'image' => ''
      },
      'extra' => {
        'raw_info' => {}
      }
    )
  end
end
