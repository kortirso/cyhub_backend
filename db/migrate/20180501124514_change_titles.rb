class ChangeTitles < ActiveRecord::Migration[5.2]
  def change
    change_column :partners, :description, :text
    rename_column :members, :description, :title
    add_column :members, :description, :text
  end
end
