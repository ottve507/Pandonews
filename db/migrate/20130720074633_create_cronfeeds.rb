class CreateCronfeeds < ActiveRecord::Migration
  def change
    create_table :cronfeeds do |t|
      t.string :address
      t.integer :plate_id
      t.integer :user_id

      t.timestamps
    end
  end
end
