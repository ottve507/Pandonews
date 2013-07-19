class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.string :headline
      t.string :location
      t.integer :origin

      t.timestamps
    end
  end
end
