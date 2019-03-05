class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :is_admin, :boolean, default: false
  end
end
