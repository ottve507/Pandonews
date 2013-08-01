class AddLanguageToCronfeeds < ActiveRecord::Migration
  def change
    add_column :cronfeeds, :language, :string
  end
end
