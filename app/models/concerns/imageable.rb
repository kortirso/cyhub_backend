# Imageable for models
module Imageable
  extend ActiveSupport::Concern
  include Rails.application.routes.url_helpers

  included do
    has_one_attached :image
  end

  def image_link
    return nil unless image.attached?
    ENV['ROOT_URL'] + rails_blob_url(image, disposition: 'attachment', only_path: true)
  end
end
