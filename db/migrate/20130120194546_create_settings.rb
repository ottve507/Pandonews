class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :location
      t.string :primary_language
      t.string :languages
      t.boolean :image_choice
      t.boolean :primary_language_choice
      t.boolean :languages_choice
      t.boolean :location_choice
      t.string :firstname
      t.string :lastname
      t.string :username
      t.string :email
      t.boolean :show_rating
      t.integer :user_id

      t.timestamps
    end
  end
end
