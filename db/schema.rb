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

ActiveRecord::Schema[8.1].define(version: 2026_04_09_204521) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "parcels", force: :cascade do |t|
    t.decimal "area_acres"
    t.decimal "center_latitude"
    t.decimal "center_longitude"
    t.datetime "created_at", null: false
    t.string "name"
    t.jsonb "polygon_geojson"
    t.bigint "property_id", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_parcels_on_property_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "address"
    t.string "commonage_reference"
    t.datetime "created_at", null: false
    t.decimal "latitude"
    t.decimal "longitude"
    t.string "name"
    t.text "notes"
    t.datetime "updated_at", null: false
  end

  create_table "property_ownerships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "ended_on"
    t.string "ownership_type"
    t.bigint "property_id", null: false
    t.date "started_on"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["property_id"], name: "index_property_ownerships_on_property_id"
    t.index ["user_id"], name: "index_property_ownerships_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "address"
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "first_name"
    t.boolean "is_verified", default: false, null: false
    t.string "last_name"
    t.string "password_digest", null: false
    t.string "phone"
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "verification_documents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "document_type"
    t.text "notes"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_verification_documents_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "parcels", "properties"
  add_foreign_key "posts", "users"
  add_foreign_key "property_ownerships", "properties"
  add_foreign_key "property_ownerships", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "verification_documents", "users"
end
