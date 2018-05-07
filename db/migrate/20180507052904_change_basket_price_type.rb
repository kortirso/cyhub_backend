class ChangeBasketPriceType < ActiveRecord::Migration[5.2]
  def change
    change_column :baskets, :amount, :decimal, precision: 10, scale: 2
  end
end
