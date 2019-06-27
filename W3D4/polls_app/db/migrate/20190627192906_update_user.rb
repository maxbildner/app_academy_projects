class UpdateUser < ActiveRecord::Migration[5.2]
  def change

    rename_column :polls, :auther_id, :author_id
  end
end
