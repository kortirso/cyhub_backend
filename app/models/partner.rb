# Represents partners
class Partner < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :logo

  validates :name, :label, :description, :link, presence: true

  def logo_link
    return nil unless logo.attached?
    ENV['ROOT_URL'] + rails_blob_url(logo, disposition: 'attachment', only_path: true)
  end
end
