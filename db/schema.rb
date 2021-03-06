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

ActiveRecord::Schema.define(version: 20170605135546) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "point_creator_job_statuses", force: :cascade do |t|
    t.string "job"
    t.boolean "done", default: false, null: false
    t.string "message"
    t.bigint "point_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["point_id"], name: "index_point_creator_job_statuses_on_point_id"
  end

  create_table "points", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "trip_id", null: false
    t.float "lat", null: false
    t.float "long", null: false
    t.string "name"
    t.index ["trip_id"], name: "index_points_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
