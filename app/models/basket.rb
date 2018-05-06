# Represents members basket for products
class Basket < ApplicationRecord
  belongs_to :member

  validates :member, :amount, presence: true
  validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
