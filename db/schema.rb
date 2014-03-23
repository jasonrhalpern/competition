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

ActiveRecord::Schema.define(version: 20140323175857) do

  create_table "awards", force: true do |t|
    t.integer  "distinction_id"
    t.integer  "entry_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "awards", ["distinction_id"], name: "index_awards_on_distinction_id"
  add_index "awards", ["entry_id"], name: "index_awards_on_entry_id"
  add_index "awards", ["event_id"], name: "index_awards_on_event_id"

  create_table "categories", force: true do |t|
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.text     "description"
    t.integer  "user_id"
    t.integer  "entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["entry_id"], name: "index_comments_on_entry_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "distinctions", force: true do |t|
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entries", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "content_type"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["event_id"], name: "index_entries_on_event_id"
  add_index "entries", ["user_id"], name: "index_entries_on_user_id"

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "entry_fee"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "close_date"
    t.integer  "entries_count", default: 0
  end

  add_index "events", ["category_id"], name: "index_events_on_category_id"
  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "username"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: true do |t|
    t.integer  "entry_id"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["entry_id"], name: "index_votes_on_entry_id"
  add_index "votes", ["user_id"], name: "index_votes_on_user_id"

end
