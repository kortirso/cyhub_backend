# Represensts event for cyhub members
class Event < ApplicationRecord
  has_one_attached :image

  validates :name, :description, :link, presence: true

  def image_content
    image.attached? ? Base64.encode64(image.attachment.blob.download) : nil
  end
end
