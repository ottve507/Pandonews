class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.text :content
      t.integer :commentable_id
      t.string :commentable_type
      t.string :ancestry

      t.timestamps
    end
    add_index :comments, :ancestry
    add_column :comments, :up_votes, :integer, :null => false, :default => 0
    add_column :comments, :down_votes, :integer, :null => false, :default => 0
  end
end
