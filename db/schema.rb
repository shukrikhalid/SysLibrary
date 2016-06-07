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

ActiveRecord::Schema.define(version: 20160605071845) do

  create_table "bookings", force: :cascade do |t|
    t.date     "booking_date_start"
    t.date     "booking_date_end"
    t.date     "booking_date_return"
    t.string   "status",              limit: 255
    t.integer  "book_id",             limit: 4
    t.integer  "user_id",             limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "bookings", ["book_id"], name: "index_bookings_on_book_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "book_isbn",    limit: 255
    t.string   "book_title",   limit: 255
    t.string   "book_author",  limit: 255
    t.string   "book_status",  limit: 255
    t.integer  "book_edition", limit: 4
    t.string   "book_image",   limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_ic",         limit: 255
    t.string   "user_name",       limit: 255
    t.string   "user_email",      limit: 255
    t.string   "password_digest", limit: 255
    t.string   "user_level",      limit: 255
    t.string   "user_address",    limit: 255
    t.string   "user_contact",    limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_foreign_key "bookings", "books"
  add_foreign_key "bookings", "users"
end
