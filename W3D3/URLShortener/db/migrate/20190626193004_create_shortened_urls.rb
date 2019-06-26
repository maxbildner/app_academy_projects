class CreateShortenedUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :shortened_urls do |t|     # table will be called "shortened_urls", t = table definition object
      t.string :short_url
      t.string :long_url
      t.integer :user_id, null: false       # ?how would we remove these nullcontraints after the migration?                    # id of user who submitted the url
      t.timestamps
    end
  end
end

# class CreateShortenedUrls < ActiveRecord::Migration[5.2]
#   add_index :shortened_urls, short_url
# end
