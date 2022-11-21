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

ActiveRecord::Schema[7.0].define(version: 2022_11_21_080105) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
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
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.datetime "time"
    t.integer "tax_income_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "method"
    t.string "phone"
    t.index ["tax_income_id"], name: "index_appointments_on_tax_income_id", unique: true
  end

  create_table "document_histories", force: :cascade do |t|
    t.integer "document_id", null: false
    t.integer "user_id", null: false
    t.integer "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.index ["document_id"], name: "index_document_histories_on_document_id"
    t.index ["user_id"], name: "index_document_histories_on_user_id"
  end

  create_table "documents", force: :cascade do |t|
    t.integer "state"
    t.string "name"
    t.integer "tax_income_id", null: false
    t.integer "user_id", null: false
    t.integer "lawyer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "export_status"
    t.integer "exported_by_id"
    t.integer "document_number"
    t.index ["exported_by_id"], name: "index_documents_on_exported_by_id"
    t.index ["lawyer_id"], name: "index_documents_on_lawyer_id"
    t.index ["tax_income_id"], name: "index_documents_on_tax_income_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "estimations", force: :cascade do |t|
    t.string "first_name"
    t.boolean "first_time", default: 0
    t.integer "home_changes", default: 0
    t.integer "rentals_mortgages", default: 0
    t.boolean "professional_company_activity", default: 0
    t.integer "real_state_trade", default: 0
    t.boolean "with_couple", default: 0
    t.integer "income_rent", default: 0
    t.integer "shares_trade", default: 0
    t.boolean "outside_alava", default: 0
    t.float "price", default: -1
    t.integer "tax_income_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tax_income_id"], name: "index_estimations_on_tax_income_id"
    t.index ["user_id"], name: "index_estimations_on_user_id"
  end

  create_table "tax_incomes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.boolean "paid"
    t.integer "price"
    t.string "observations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state", default: 0
    t.integer "lawyer_id"
    t.string "payment"
    t.index ["lawyer_id"], name: "index_tax_incomes_on_lawyer_id"
    t.index ["user_id"], name: "index_tax_incomes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.integer "account_type", default: 0
    t.string "stripe_customer_id"
    t.string "provider"
    t.string "uid"
    t.datetime "confirmed_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointments", "tax_incomes"
  add_foreign_key "document_histories", "documents"
  add_foreign_key "document_histories", "users"
  add_foreign_key "documents", "tax_incomes"
  add_foreign_key "documents", "users"
  add_foreign_key "documents", "users", column: "exported_by_id"
  add_foreign_key "documents", "users", column: "lawyer_id"
  add_foreign_key "estimations", "tax_incomes"
  add_foreign_key "estimations", "users"
  add_foreign_key "tax_incomes", "users"
  add_foreign_key "tax_incomes", "users", column: "lawyer_id"
end
