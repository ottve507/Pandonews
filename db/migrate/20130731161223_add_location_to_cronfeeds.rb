class AddLocationToCronfeeds < ActiveRecord::Migration
  def change
    add_column :cronfeeds, :location, :string
  end
end
