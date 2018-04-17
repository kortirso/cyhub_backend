class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.text :description
      t.integer :member_id
      t.timestamps
    end
    add_index :photos, :member_id
  end
end
