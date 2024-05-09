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

ActiveRecord::Schema[7.1].define(version: 2024_05_09_134302) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "decouvertes", force: :cascade do |t|
    t.text "circuit_acc_text"
    t.string "circuit_acc_img"
    t.text "anim_scol_text"
    t.string "anim_scol_img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "engagements", force: :cascade do |t|
    t.text "sensib"
    t.text "protec"
    t.text "rules"
    t.text "partner"
    t.string "engagements_img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "generals", force: :cascade do |t|
    t.text "general_pres"
    t.string "home_img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "points", force: :cascade do |t|
    t.string "title"
    t.text "infos"
    t.float "lat"
    t.float "long"
    t.string "video"
    t.string "audio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roads", force: :cascade do |t|
    t.bigint "sentier_id", null: false
    t.bigint "point_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["point_id"], name: "index_roads_on_point_id"
    t.index ["sentier_id"], name: "index_roads_on_sentier_id"
  end

  create_table "sentiers", force: :cascade do |t|
    t.string "title"
    t.time "duration"
    t.string "difficulty"
    t.string "image"
    t.string "starting_point_lat"
    t.string "starting_point_long"
    t.string "arrival_point_lat"
    t.string "arrival_point_long"
    t.boolean "is_theme"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "roads", "points"
  add_foreign_key "roads", "sentiers"
end
