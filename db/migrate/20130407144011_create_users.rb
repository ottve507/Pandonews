class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :firstname
      t.string :lastname
      t.string :location
      t.string :language
      t.string :email
      t.string :image
      t.string :image_small

      t.timestamps
    end
    add_column :users, :up_votes, :integer, :null => false, :default => 0
    add_column :users, :down_votes, :integer, :null => false, :default => 0
  end
end
