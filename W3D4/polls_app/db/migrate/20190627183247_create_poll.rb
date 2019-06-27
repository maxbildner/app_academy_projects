class CreatePoll < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.string :title, null: false
      t.integer :auther_id, null: true
    end
    add_index(:polls, :auther_id)
  end
end
