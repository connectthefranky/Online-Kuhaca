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

ActiveRecord::Schema.define(version: 20170109214802) do

  create_table "comments", force: :cascade do |t|
    t.text     "comment",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.integer  "recipe_id",  limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "user_email", limit: 255
  end

  create_table "ingredients", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "measurements", force: :cascade do |t|
    t.integer  "ingredient_id", limit: 4
    t.integer  "recipe_id",     limit: 4
    t.string   "measure",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "measurements", ["ingredient_id"], name: "index_measurements_on_ingredient_id", using: :btree
  add_index "measurements", ["recipe_id"], name: "index_measurements_on_recipe_id", using: :btree

  create_table "measuring_units", force: :cascade do |t|
    t.text     "measure",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "rating",     limit: 4
    t.integer  "recipe_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "recipe_tags", force: :cascade do |t|
    t.integer  "tag_id",     limit: 4
    t.integer  "recipe_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "recipe_tags", ["recipe_id"], name: "index_recipe_tags_on_recipe_id", using: :btree
  add_index "recipe_tags", ["tag_id"], name: "index_recipe_tags_on_tag_id", using: :btree

  create_table "recipes", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.text     "description",        limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "user_id",            limit: 4
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.float    "average_rating",     limit: 24
  end

  create_table "tags", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
