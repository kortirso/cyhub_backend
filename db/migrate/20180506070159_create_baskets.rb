class CreateBaskets < ActiveRecord::Migration[5.2]
  def change
    create_table :baskets do |t|
      t.integer :member_id
      t.integer :amount, default: 0, null: false
      t.timestamps
    end
    add_index :baskets, :member_id
  end
end
