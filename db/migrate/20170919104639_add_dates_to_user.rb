class AddDatesToUser < ActiveRecord::Migration[5.1]
    def change
        add_column :users, :date_from, :datetime
        add_column :users, :date_to, :datetime
    end
end
