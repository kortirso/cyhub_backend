# Represents partners
class Partner < ApplicationRecord
  has_one_attached :logo

  validates :name, :label, :description, :link, presence: true

  def logo_content
    logo.attachment.blob.download
  end
end
