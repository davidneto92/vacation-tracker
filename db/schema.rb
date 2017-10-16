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

ActiveRecord::Schema.define(version: 20171016152058) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "parks", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "park_type"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "nps_url"
    t.boolean "drivable", default: true
  end

  create_table "saved_trips", force: :cascade do |t|
    t.jsonb "start_point", null: false
    t.string "destination_name", null: false
    t.integer "destination_park_id"
    t.integer "found_parks", array: true
    t.jsonb "directions_data", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "trip_name", null: false
    t.index ["user_id"], name: "index_saved_trips_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vacations", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "location", null: false
    t.text "description"
    t.boolean "display_public", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_vacations_on_user_id"
  end

  create_table "visits", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "vacation_id"
    t.integer "park_id"
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["park_id"], name: "index_visits_on_park_id"
    t.index ["user_id"], name: "index_visits_on_user_id"
    t.index ["vacation_id"], name: "index_visits_on_vacation_id"
  end

  add_foreign_key "saved_trips", "users"
  add_foreign_key "vacations", "users"
  add_foreign_key "visits", "parks"
  add_foreign_key "visits", "users"
  add_foreign_key "visits", "vacations"
end
