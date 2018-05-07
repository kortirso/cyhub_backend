# Represents members basket for products
class Basket < ApplicationRecord
  belongs_to :member

  has_many :positions, dependent: :destroy
  has_many :products, through: :positions

  validates :member, :amount, presence: true
  validates :amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def add_product(product)
    current_position = positions.find_by(product_id: product.id)
    current_position.present? ? current_position.update(amount: current_position.amount + 1) : positions.create(product: product, amount: 1)
    recalc
  end

  def clear
    positions.destroy_all
    recalc
  end

  def recalc
    self.amount = 0
    positions.includes(:product).each do |position|
      self.amount += position.product.price * position.amount
    end
    save
  end
end
