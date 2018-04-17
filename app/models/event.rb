# Represensts event for cyhub members
class Event < ApplicationRecord
  validates :name, :description, :link, presence: true
end
