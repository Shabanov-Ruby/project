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

ActiveRecord::Schema[7.2].define(version: 2024_10_18_124446) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "body_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "call_requests", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.string "name"
    t.string "phone"
    t.datetime "preferred_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_call_requests_on_car_id"
  end

  create_table "cars", force: :cascade do |t|
    t.bigint "model_id", null: false
    t.bigint "brand_id", null: false
    t.integer "year"
    t.decimal "price"
    t.text "description"
    t.bigint "color_id", null: false
    t.bigint "body_type_id", null: false
    t.bigint "engine_type_id", null: false
    t.bigint "gearbox_type_id", null: false
    t.bigint "drive_type_id", null: false
    t.bigint "fuel_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "generation_id", null: false
    t.index ["body_type_id"], name: "index_cars_on_body_type_id"
    t.index ["brand_id"], name: "index_cars_on_brand_id"
    t.index ["color_id"], name: "index_cars_on_color_id"
    t.index ["drive_type_id"], name: "index_cars_on_drive_type_id"
    t.index ["engine_type_id"], name: "index_cars_on_engine_type_id"
    t.index ["fuel_type_id"], name: "index_cars_on_fuel_type_id"
    t.index ["gearbox_type_id"], name: "index_cars_on_gearbox_type_id"
    t.index ["generation_id"], name: "index_cars_on_generation_id"
    t.index ["model_id"], name: "index_cars_on_model_id"
  end

  create_table "colors", force: :cascade do |t|
    t.string "name"
    t.string "hex_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drive_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "engine_types", force: :cascade do |t|
    t.string "name"
    t.integer "engine_power"
    t.decimal "engine_capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fuel_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gearbox_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "generations", force: :cascade do |t|
    t.bigint "model_id", null: false
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.text "modernization"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_generations_on_model_id"
  end

  create_table "history_cars", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.string "vin"
    t.string "registration_number"
    t.integer "last_mileage"
    t.boolean "registration_restrictions"
    t.boolean "wanted_status"
    t.boolean "pledge_status"
    t.integer "previous_owners"
    t.boolean "accidents_found"
    t.boolean "repair_estimates_found"
    t.boolean "taxi_usage"
    t.boolean "carsharing_usage"
    t.boolean "diagnostics_found"
    t.boolean "technical_inspection_found"
    t.boolean "imported"
    t.boolean "insurance_found"
    t.boolean "recall_campaigns_found"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_history_cars_on_car_id"
    t.index ["vin"], name: "index_history_cars_on_vin", unique: true
  end

  create_table "images", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.string "url"
    t.string "description"
    t.boolean "is_primary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_images_on_car_id"
  end

  create_table "models", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_models_on_brand_id"
  end

  add_foreign_key "call_requests", "cars"
  add_foreign_key "cars", "body_types"
  add_foreign_key "cars", "brands"
  add_foreign_key "cars", "colors"
  add_foreign_key "cars", "drive_types"
  add_foreign_key "cars", "engine_types"
  add_foreign_key "cars", "fuel_types"
  add_foreign_key "cars", "gearbox_types"
  add_foreign_key "cars", "generations"
  add_foreign_key "cars", "models"
  add_foreign_key "generations", "models"
  add_foreign_key "history_cars", "cars"
  add_foreign_key "images", "cars"
  add_foreign_key "models", "brands"
end
