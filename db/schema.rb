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

ActiveRecord::Schema.define(version: 20150303160831) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "vote_counts", force: :cascade do |t|
    t.integer  "task_id",                null: false
    t.integer  "amount",     default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "vote_counts", ["task_id"], name: "index_vote_counts_on_task_id", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "task_id",                null: false
    t.integer  "user_id",                null: false
    t.integer  "revision",   default: 1, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "votes", ["task_id"], name: "index_votes_on_task_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
