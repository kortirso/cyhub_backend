# Represents products
class Product < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :image

  has_many :positions, dependent: :destroy
  has_many :baskets, through: :positions

  validates :name, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def image_link
    return nil unless image.attached?
    ENV['ROOT_URL'] + rails_blob_url(image, disposition: 'attachment', only_path: true)
  end
end
