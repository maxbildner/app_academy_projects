class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|          # t = table definition object?
      t.string :email, null: false      # create column w/ values string data type, must be given a non-null value (can't have null values)
      t.timestamps                      # column that records timestamp of when data inserted?
    end
    
    # add_index(table_name, col_name, options_hash). this needs to be outside def change!!
    add_index(:users, :email, unique: true)      # why add uniqueness options hash here, and not inside create block above?
  end
end
