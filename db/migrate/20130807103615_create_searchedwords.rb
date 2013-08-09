class CreateSearchedwords < ActiveRecord::Migration
  def change
    create_table :searchedwords do |t|
      t.string :location
      t.float :latitude
      t.float :longitude
      t.string :altname
      t.boolean :good

      t.timestamps
    end
  end
end
