# Represents user object
class User < ApplicationRecord
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: %i[facebook]

    has_many :identities, dependent: :destroy

    validates :role, presence: true, inclusion: { in: %w[user admin] }

    scope :active, -> { where(active: true) }

    def self.find_for_oauth(auth)
        identity = Identity.find_for_oauth(auth)
        return identity.user if identity.present?
        user = User.find_or_create_by(email: auth.info[:email]) do |u|
            u.password = Devise.friendly_token[0, 20]
        end
        user.identities.create(provider: auth.provider, uid: auth.uid)
        user
    end

    def admin?
        role == 'admin'
    end

    def days_left
        date_to.present? ? ((date_to.to_i - Time.now.to_i) / 86400) : 0
    end
end
