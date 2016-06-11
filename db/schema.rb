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

ActiveRecord::Schema.define(version: 20160611093205) do

  create_table "bursts", force: :cascade do |t|
    t.integer  "child_id",   limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "bursts", ["child_id"], name: "index_bursts_on_child_id", using: :btree

  create_table "children", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4,                                   null: false
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.time     "calm_time",              default: '2000-01-01 12:00:00', null: false
  end

  add_index "children", ["parent_id"], name: "index_children_on_parent_id", using: :btree

  create_table "parents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "worries", force: :cascade do |t|
    t.boolean  "notificationed",           default: false, null: false
    t.integer  "parent_id",      limit: 4,                 null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "worries", ["parent_id"], name: "index_worries_on_parent_id", using: :btree

  add_foreign_key "bursts", "children"
  add_foreign_key "children", "parents"
  add_foreign_key "worries", "parents"
end
