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

ActiveRecord::Schema.define(version: 20141208160348) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: true do |t|
    t.integer  "band_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.string   "album_type"
    t.string   "name"
  end

  add_index "albums", ["band_id"], name: "index_albums_on_band_id", using: :btree

  create_table "band_members", force: true do |t|
    t.integer  "band_id"
    t.string   "name",                        null: false
    t.date     "birth_date"
    t.string   "gender"
    t.text     "description"
    t.boolean  "solo",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "band_members", ["band_id", "name"], name: "index_band_members_on_band_id_and_name", unique: true, using: :btree
  add_index "band_members", ["band_id"], name: "index_band_members_on_band_id", using: :btree

  create_table "bands", force: true do |t|
    t.string   "name",         null: false
    t.date     "date_created"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "avatars"
    t.text     "description"
    t.string   "tagline"
    t.integer  "submitter_id"
  end

  add_index "bands", ["name"], name: "index_bands_on_name", using: :btree
  add_index "bands", ["submitter_id"], name: "index_bands_on_submitter_id", using: :btree

  create_table "genre_taggings", force: true do |t|
    t.integer  "album_id",   null: false
    t.integer  "genre_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "genre_taggings", ["album_id", "genre_id"], name: "index_genre_taggings_on_album_id_and_genre_id", unique: true, using: :btree
  add_index "genre_taggings", ["album_id"], name: "index_genre_taggings_on_album_id", using: :btree
  add_index "genre_taggings", ["genre_id"], name: "index_genre_taggings_on_genre_id", using: :btree

  create_table "genres", force: true do |t|
    t.string   "category",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "genres", ["category"], name: "index_genres_on_category", unique: true, using: :btree

  create_table "images", force: true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment"
  end

  create_table "tracks", force: true do |t|
    t.integer  "album_id",   null: false
    t.time     "length"
    t.string   "track_type"
    t.text     "lyrics"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tracks", ["album_id"], name: "index_tracks_on_album_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", using: :btree

end
