class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.string :link
      t.datetime :started_at
      t.datetime :finished_at
      t.text :description
      t.timestamps
    end
  end
end
