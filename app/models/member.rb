# Represents member model
class Member < ApplicationRecord
  SECONDS_IN_DAY = 86_400

  belongs_to :user

  has_one :basket, dependent: :destroy
  has_one_attached :avatar

  validates :user, :name, :title, presence: true

  scope :active, -> { where(active: true) }

  after_commit :create_basket, on: :create

  def days_left
    date_to.present? ? ((date_to.to_i - Time.now.to_i) / SECONDS_IN_DAY) : 0
  end

  def avatar_content
    avatar.attached? ? Base64.encode64(avatar.attachment.blob.download) : nil
  end

  def credit
    basket.amount
  end

  private def create_basket
    Basket.create(member: self)
  end
end
