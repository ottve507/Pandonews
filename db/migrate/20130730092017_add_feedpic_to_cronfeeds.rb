class AddFeedpicToCronfeeds < ActiveRecord::Migration
  def change
    add_column :cronfeeds, :feedpic, :string
  end
end
