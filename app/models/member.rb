# Represents member model
class Member < ApplicationRecord
    SECONDS_IN_DAY = 86400

    belongs_to :user

    validates :user_id, :name, :description, presence: true

    scope :active, -> { where(active: true) }

    def days_left
        date_to.present? ? ((date_to.to_i - Time.now.to_i) / SECONDS_IN_DAY) : 0
    end
end
