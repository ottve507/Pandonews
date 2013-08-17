class AddLinkobjectToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :linkobject, :string
  end
end
