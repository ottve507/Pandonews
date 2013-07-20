class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.text :content
      t.text :url
      t.datetime :published_at
      t.string :guid
      t.string :location
      t.string :language
      t.integer :user_id
      t.string :url_to_feed
      t.string :type_of_feed
      t.string :thumbnail_url
      t.integer :original_plate_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_column :feeds, :up_votes, :integer, :null => false, :default => 0
    add_column :feeds, :down_votes, :integer, :null => false, :default => 0
  end
end
