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

ActiveRecord::Schema.define(version: 20150621080135) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "directories", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",       null: false
    t.string   "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "directories", ["user_id"], name: "index_directories_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.integer  "directory_id", null: false
    t.integer  "fileitem_id"
    t.string   "url"
    t.string   "message"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "events", ["directory_id"], name: "index_events_on_directory_id", using: :btree
  add_index "events", ["fileitem_id"], name: "index_events_on_fileitem_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "fileitems", force: :cascade do |t|
    t.integer  "directory_id"
    t.string   "name",         null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.binary   "bindata"
  end

  add_index "fileitems", ["directory_id"], name: "index_fileitems_on_directory_id", using: :btree

  create_table "shared_directories", force: :cascade do |t|
    t.integer  "directory_id", null: false
    t.integer  "user_id",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "shared_directories", ["directory_id"], name: "index_shared_directories_on_directory_id", using: :btree
  add_index "shared_directories", ["user_id"], name: "index_shared_directories_on_user_id", using: :btree

  create_table "shared_files", force: :cascade do |t|
    t.integer  "fileitem_id", null: false
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "shared_files", ["fileitem_id"], name: "index_shared_files_on_fileitem_id", using: :btree
  add_index "shared_files", ["user_id"], name: "index_shared_files_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "directories", "users"
  add_foreign_key "events", "directories"
  add_foreign_key "events", "fileitems"
  add_foreign_key "events", "users"
  add_foreign_key "fileitems", "directories"
  add_foreign_key "shared_directories", "directories"
  add_foreign_key "shared_directories", "users"
  add_foreign_key "shared_files", "fileitems"
  add_foreign_key "shared_files", "users"
end
