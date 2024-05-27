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

ActiveRecord::Schema[7.1].define(version: 2024_05_27_171349) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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
    t.string "image_1"
    t.text "image_1_commment"
    t.string "image_2"
    t.text "image_2_commment"
    t.string "image_3"
    t.text "image_3_commment"
    t.string "image_4"
    t.text "image_4_commment"
    t.string "image_5"
    t.text "image_5_commment"
    t.string "image_6"
    t.text "image_6_commment"
    t.string "image_7"
    t.text "image_7_commment"
    t.string "image_8"
    t.text "image_8_commment"
    t.string "image_9"
    t.text "image_9_commment"
    t.string "image_10"
    t.text "image_10_commment"
    t.string "qr_code"
  end

  create_table "qrcodes", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roads", force: :cascade do |t|
    t.bigint "sentier_id", null: false
    t.bigint "point_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["point_id"], name: "index_roads_on_point_id"
    t.index ["sentier_id"], name: "index_roads_on_sentier_id"
  end

  create_table "sentiers", force: :cascade do |t|
    t.string "title"
    t.string "difficulty"
    t.string "image"
    t.string "starting_point_lat"
    t.string "starting_point_long"
    t.string "arrival_point_lat"
    t.string "arrival_point_long"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "color"
    t.boolean "is_theme", default: false, null: false
    t.boolean "is_boucle", default: false, null: false
    t.string "depart_address", default: "", null: false
    t.string "arrival_address", default: "", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "roads", "points"
  add_foreign_key "roads", "sentiers"
end
