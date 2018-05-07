# Represensts event for cyhub members
class Event < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :image

  validates :name, :description, :link, presence: true

  def image_link
    return nil unless image.attached?
    ENV['ROOT_URL'] + rails_blob_url(image, disposition: 'attachment', only_path: true)
  end
end
