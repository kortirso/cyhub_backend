# Represents positions in basket
class Position < ApplicationRecord
  belongs_to :basket
  belongs_to :product

  validates :basket, :product, :amount, presence: true
  validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
