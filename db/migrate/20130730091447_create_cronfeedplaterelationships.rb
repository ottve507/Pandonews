class CreateCronfeedplaterelationships < ActiveRecord::Migration
  def change
    create_table :cronfeedplaterelationships do |t|
      t.integer :plate_id
      t.integer :cronfeed_id

      t.timestamps
    end
  end
end
