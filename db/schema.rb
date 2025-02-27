# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_28_203800) do
  create_table "dogs", force: :cascade do |t|
    t.string "name"
    t.boolean "Monday"
    t.boolean "Tuesday"
    t.boolean "Wednesday"
    t.boolean "Thursday"
    t.boolean "Friday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dropoffs", force: :cascade do |t|
    t.integer "dog_id"
    t.integer "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pickups", force: :cascade do |t|
    t.integer "dog_id"
    t.integer "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.date "date"
    t.text "raw_assignments", default: "{}"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trips", force: :cascade do |t|
    t.integer "truck_id"
    t.date "date"
    t.boolean "arrived"
    t.boolean "departed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
