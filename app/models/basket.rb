# Represents members basket for products
class Basket < ApplicationRecord
  belongs_to :member

  has_many :positions, dependent: :destroy
  has_many :products, through: :positions

  validates :member, :amount, presence: true
  validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recalc
    self.amount = 0
    positions.includes(:product).each do |position|
      self.amount += position.product.price * position.amount
    end
    save
  end

  def clear
    positions.destroy_all
    update(amount: 0)
  end
end
