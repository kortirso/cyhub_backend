# Represents live photos
class Photo < ApplicationRecord
  has_one_attached :image

  belongs_to :member

  validates :member, presence: true

  def image_content
    image.attached? ? Base64.encode64(image.attachment.blob.download) : nil
  end
end
