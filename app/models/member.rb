# Represents member model
class Member < ApplicationRecord
  include Rails.application.routes.url_helpers

  SECONDS_IN_DAY = 86_400

  belongs_to :user

  has_one_attached :avatar
  has_one :basket, dependent: :destroy
  has_many :photos, dependent: :destroy

  validates :user, :name, :title, presence: true

  scope :active, -> { where(active: true) }

  after_commit :create_basket, on: :create

  def days_left
    date_to.present? ? ((date_to.to_i - Time.now.to_i) / SECONDS_IN_DAY) : 0
  end

  def avatar_link
    return nil unless avatar.attached?
    domain + rails_blob_url(avatar, only_path: true)
  end

  def credit
    basket.amount
  end

  private

  def create_basket
    Basket.create(member: self)
  end

  def domain
    ENV['ROOT_URL'] || 'http://localhost:5000'
  end
end
