class AddIndexToPost < ActiveRecord::Migration[5.2]
  def change
    add_index :posts, :name, unique: true
  end
end
