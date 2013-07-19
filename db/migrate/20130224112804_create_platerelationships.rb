class CreatePlaterelationships < ActiveRecord::Migration
  def change
    create_table :platerelationships do |t|
      t.integer :plate_id
      t.integer :feed_id

      t.timestamps
    end
  end
end
