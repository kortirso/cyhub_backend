# Represents products
class Product < ApplicationRecord
  has_one_attached :image

  has_many :positions, dependent: :destroy
  has_many :baskets, through: :positions

  validates :name, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  def image_content
    image.attached? ? Base64.encode64(image.attachment.blob.download) : nil
  end
end
