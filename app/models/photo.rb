# Represents live photos
class Photo < ApplicationRecord
  include Imageable

  belongs_to :member

  validates :member, presence: true

  def self.with_real_attachments
    select { |photo| photo.image.attached? }
  end
end
