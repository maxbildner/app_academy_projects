class AddUsernameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string, null: false
    remove_column :users, :name
    remove_column :users, :email           # first table name, then column name
    add_index :users, :username, unique: true 
  end
end
