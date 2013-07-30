class AddFeedTitleToCronfeeds < ActiveRecord::Migration
  def change
    add_column :cronfeeds, :feed_title, :string
  end
end
