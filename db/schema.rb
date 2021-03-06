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

ActiveRecord::Schema.define(version: 20160331092900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachinary_files", force: :cascade do |t|
    t.integer  "attachinariable_id"
    t.string   "attachinariable_type"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachinary_files", ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bookings", ["session_id"], name: "index_bookings_on_session_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "lessons", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.text     "description"
    t.string   "address"
    t.string   "yoga_category"
    t.string   "picture1"
    t.string   "picture2"
    t.string   "picture3"
    t.integer  "price"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "lessons", ["user_id"], name: "index_lessons_on_user_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.datetime "starts_at"
    t.integer  "lesson_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "conf_status", default: false
    t.integer  "maxnumber"
  end

  add_index "sessions", ["lesson_id"], name: "index_sessions_on_lesson_id", using: :btree

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
    t.string   "last_name"
    t.string   "first_name"
    t.date     "birth_date"
    t.text     "description"
    t.string   "picture"
    t.string   "start_date"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "token_expiry"
    t.string   "category"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "bookings", "sessions"
  add_foreign_key "bookings", "users"
  add_foreign_key "lessons", "users"
  add_foreign_key "sessions", "lessons"
end
