# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130816123111) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.string   "ancestry"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "up_votes",         :default => 0, :null => false
    t.integer  "down_votes",       :default => 0, :null => false
  end

  add_index "comments", ["ancestry"], :name => "index_comments_on_ancestry"

  create_table "cronfeedplaterelationships", :force => true do |t|
    t.integer  "plate_id"
    t.integer  "cronfeed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "cronfeeds", :force => true do |t|
    t.string   "address"
    t.integer  "plate_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "feedpic"
    t.string   "feed_title"
    t.string   "language"
    t.string   "location"
  end

  create_table "feeds", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "url"
    t.datetime "published_at"
    t.string   "guid"
    t.string   "location"
    t.string   "language"
    t.integer  "user_id"
    t.string   "url_to_feed"
    t.string   "type_of_feed"
    t.string   "thumbnail_url"
    t.integer  "original_plate_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "up_votes",          :default => 0, :null => false
    t.integer  "down_votes",        :default => 0, :null => false
    t.string   "feedpic"
    t.string   "summary"
    t.string   "linkobject"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "identities", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "impressions", :force => true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "ip_address"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "platerelationships", :force => true do |t|
    t.integer  "plate_id"
    t.integer  "feed_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "plates", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "language"
    t.boolean  "public"
    t.integer  "user_id"
    t.text     "summmary"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "relationships", :force => true do |t|
    t.string   "headline"
    t.string   "location"
    t.integer  "origin"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "searchedwords", :force => true do |t|
    t.string   "location"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "altname"
    t.boolean  "good"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "searches", :force => true do |t|
    t.string   "keywords"
    t.string   "location"
    t.string   "language"
    t.string   "searchall"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "settings", :force => true do |t|
    t.string   "location"
    t.string   "primary_language"
    t.string   "languages"
    t.boolean  "image_choice"
    t.boolean  "primary_language_choice"
    t.boolean  "languages_choice"
    t.boolean  "location_choice"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "username"
    t.string   "email"
    t.boolean  "show_rating"
    t.integer  "user_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "profilepicture_file_name"
    t.string   "profilepicture_content_type"
    t.integer  "profilepicture_file_size"
    t.datetime "profilepicture_updated_at"
  end

  create_table "suggestions", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "userplaterelationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "secondaryplate_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "location"
    t.string   "language"
    t.string   "email"
    t.string   "image"
    t.string   "image_small"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "up_votes",    :default => 0, :null => false
    t.integer  "down_votes",  :default => 0, :null => false
  end

  create_table "votings", :force => true do |t|
    t.string   "voteable_type"
    t.integer  "voteable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "up_vote",       :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "votings", ["voteable_type", "voteable_id", "voter_type", "voter_id"], :name => "unique_voters", :unique => true
  add_index "votings", ["voteable_type", "voteable_id"], :name => "index_votings_on_voteable_type_and_voteable_id"
  add_index "votings", ["voter_type", "voter_id"], :name => "index_votings_on_voter_type_and_voter_id"

end
