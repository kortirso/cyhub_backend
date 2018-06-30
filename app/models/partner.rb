# Represents partners
class Partner < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one_attached :logo

  validates :name, :label, :description, :link, presence: true

  def logo_link
    return nil unless logo.attached?
    domain + rails_blob_url(logo, only_path: true)
  end

  private

  def domain
    ENV['ROOT_URL'] || 'http://localhost:5000'
  end
end
