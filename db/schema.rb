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

ActiveRecord::Schema.define(version: 20160922100902) do

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "micropost_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "favorites", ["micropost_id"], name: "index_favorites_on_micropost_id"
  add_index "favorites", ["user_id", "micropost_id"], name: "index_favorites_on_user_id_and_micropost_id", unique: true
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id"

  create_table "microposts", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "retweet"
  end

  add_index "microposts", ["user_id"], name: "index_microposts_on_user_id"

  create_table "recipes", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "title"
    t.text     "no1"
    t.text     "no2"
    t.text     "no3"
    t.text     "no4"
    t.text     "zairyo"
    t.text     "kanso"
    t.string   "img1"
    t.string   "img2"
    t.string   "img3"
    t.string   "img4"
    t.string   "img_last"
    t.string   "salada"
    t.string   "meat"
    t.string   "fish"
    t.string   "dessert"
    t.string   "addmin"
    t.string   "sappari"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "recipes", ["user_id", "created_at"], name: "index_recipes_on_user_id_and_created_at"
  add_index "recipes", ["user_id"], name: "index_recipes_on_user_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "age"
    t.integer  "gender"
    t.text     "profile"
    t.string   "url"
    t.string   "area"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
