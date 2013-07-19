class CreatePlates < ActiveRecord::Migration
  def change
    create_table :plates do |t|
      t.string :name
      t.string :location
      t.string :language
      t.boolean :public
      t.integer :user_id
      t.text :summmary

      t.timestamps
    end
  end
end
