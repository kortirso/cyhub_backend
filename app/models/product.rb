class Product < ApplicationRecord
  has_one_attached :image

  validates :name, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
