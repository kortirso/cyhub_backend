# Represents partners
class Partner < ApplicationRecord
  has_one_attached :logo

  validates :name, :label, :description, :link, presence: true

  def logo_content
    logo.attached? ? Base64.encode64(logo.attachment.blob.download) : nil
  end
end
