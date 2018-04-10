# Represents partners
class Partner < ApplicationRecord
  validates :name, :label, :description, :link, presence: true
end
