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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170401213305) do

  create_table "clacks", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "clacks", ["user_id"], name: "index_clacks_on_user_id"

  create_table "follow_mappings", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "follow_mappings", ["followee_id"], name: "index_follow_mappings_on_followee_id"
  add_index "follow_mappings", ["follower_id"], name: "index_follow_mappings_on_follower_id"

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "clack_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["clack_id"], name: "index_likes_on_clack_id"
  add_index "likes", ["user_id"], name: "index_likes_on_user_id"

  create_table "replies", force: :cascade do |t|
    t.integer  "clack_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "replies", ["clack_id"], name: "index_replies_on_clack_id"

  create_table "users", force: :cascade do |t|
    t.string   "username",   null: false
    t.string   "password",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal  "lat"
    t.decimal  "lng"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "city"
    t.string   "zipcode"
    t.string   "country"
  end

end
