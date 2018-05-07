# Represensts event for cyhub members
class Event < ApplicationRecord
  include Imageable

  validates :name, :description, :link, presence: true
end
