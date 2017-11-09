class CreateMembers < ActiveRecord::Migration[5.1]
    def change
        create_table :members do |t|
            t.string :name, default: ''
            t.text :description, default: ''
            t.integer :user_id
            t.timestamps
        end
        add_index :members, :user_id
    end
end
