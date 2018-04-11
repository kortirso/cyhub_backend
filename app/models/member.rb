# Represents member model
class Member < ApplicationRecord
  SECONDS_IN_DAY = 86_400

  has_one_attached :avatar

  belongs_to :user

  validates :user_id, :name, :description, presence: true

  scope :active, -> { where(active: true) }

  def days_left
    date_to.present? ? ((date_to.to_i - Time.now.to_i) / SECONDS_IN_DAY) : 0
  end

  def avatar_content
    avatar.attached? ? Base64.encode64(avatar.attachment.blob.download) : nil
  end
end
