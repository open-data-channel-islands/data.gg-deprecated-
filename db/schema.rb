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

ActiveRecord::Schema.define(version: 20140316123540) do

  create_table "route_overviews", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "timetable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "route_periods", force: true do |t|
    t.string   "name"
    t.integer  "start_day"
    t.integer  "end_day"
    t.text     "description"
    t.integer  "route_overview_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "route_stops", force: true do |t|
    t.integer "route_id"
    t.integer "stop_id"
    t.integer "idx"
  end

  add_index "route_stops", ["route_id"], name: "index_route_stops_on_route_id"
  add_index "route_stops", ["stop_id"], name: "index_route_stops_on_stop_id"

  create_table "routes", force: true do |t|
    t.string   "name"
    t.integer  "start_day"
    t.integer  "end_day"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "route_period_id"
  end

  create_table "stop_links", force: true do |t|
    t.integer  "time"
    t.boolean  "display"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "skip"
    t.boolean  "arrive"
    t.boolean  "depart"
    t.integer  "route_stop_id"
    t.integer  "origin_stop_link_id"
  end

  create_table "stops", force: true do |t|
    t.string   "name"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timetables", force: true do |t|
    t.integer  "effective_date"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
