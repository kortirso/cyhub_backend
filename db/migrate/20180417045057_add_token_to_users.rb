class AddTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token, :string, null: false, default: ''
  end
end
