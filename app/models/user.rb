# Represents user object
class User < ApplicationRecord
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

    validates :role, presence: true, inclusion: { in: %w[user admin] }

    def admin?
        role == 'admin'
    end
end
