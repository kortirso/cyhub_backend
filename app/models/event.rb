# Represensts event for cyhub members
class Event < ApplicationRecord
  has_one_attached :image

  validates :name, :description, :link, presence: true
end
