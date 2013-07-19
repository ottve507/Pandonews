class CreateUserplaterelationships < ActiveRecord::Migration
  def change
    create_table :userplaterelationships do |t|
      t.integer :user_id
      t.integer :secondaryplate_id

      t.timestamps
    end
  end
end
