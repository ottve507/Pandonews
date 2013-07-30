class AddFeedpicColumnToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :feedpic, :string
  end
end
