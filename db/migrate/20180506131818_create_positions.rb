class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.integer :basket_id
      t.integer :product_id
      t.integer :amount
      t.timestamps
    end
    add_index :positions, :basket_id
    add_index :positions, :product_id
  end
end
