class ChangeFieldsForUsers < ActiveRecord::Migration[5.1]
    def change
        remove_column :users, :date_from, :datetime
        remove_column :users, :date_to, :datetime
        remove_column :users, :active, :boolean
        add_column :members, :date_from, :datetime
        add_column :members, :date_to, :datetime
        add_column :members, :active, :boolean, default: false
    end
end
