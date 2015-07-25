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

ActiveRecord::Schema.define(version: 20150720223731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.integer  "deck",       default: [], null: false, array: true
    t.integer  "board",      default: [], null: false, array: true
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.integer  "game_id",                null: false
    t.integer  "score",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "memberships", ["game_id"], name: "index_memberships_on_game_id", using: :btree
  add_index "memberships", ["user_id", "game_id"], name: "index_memberships_on_user_id_and_game_id", unique: true, using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "image_url"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "access_token"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "users", ["access_token"], name: "index_users_on_access_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree

  add_foreign_key "memberships", "games"
  add_foreign_key "memberships", "users"
end
