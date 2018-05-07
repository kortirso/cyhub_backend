# Represents live photos
class Photo < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :image

  belongs_to :member

  validates :member, presence: true

  def self.with_real_attachments
    select { |photo| photo.image.attached? }
  end

  def image_link
    return nil unless image.attached?
    ENV['ROOT_URL'] + rails_blob_url(image, disposition: 'attachment', only_path: true)
  end
end
