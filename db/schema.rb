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

ActiveRecord::Schema[7.0].define(version: 2022_12_29_132622) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_histories", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "ip"
    t.datetime "time", null: false
    t.integer "action", null: false
    t.string "user_id", null: false
    t.index ["id"], name: "index_account_histories_on_id", unique: true
    t.index ["user_id"], name: "index_account_histories_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.string "record_id", null: false
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

  create_table "appointments", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.datetime "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "meeting_method", null: false
    t.string "phone"
    t.string "client_id"
    t.string "lawyer_id"
    t.string "tax_income_id"
    t.index ["client_id"], name: "index_appointments_on_client_id"
    t.index ["id"], name: "index_appointments_on_id", unique: true
    t.index ["lawyer_id"], name: "index_appointments_on_lawyer_id"
    t.index ["tax_income_id"], name: "index_appointments_on_tax_income_id", unique: true
  end

  create_table "document_histories", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "description"
    t.integer "action", null: false
    t.string "document_id", null: false
    t.string "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_document_histories_on_document_id"
    t.index ["id"], name: "index_document_histories_on_id", unique: true
    t.index ["user_id"], name: "index_document_histories_on_user_id"
  end

  create_table "documents", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "name"
    t.string "exported_by_id"
    t.integer "state", default: 0, null: false
    t.integer "export_status", default: 0, null: false
    t.integer "document_number", default: 1, null: false
    t.string "tax_income_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exported_by_id"], name: "index_documents_on_exported_by_id"
    t.index ["id"], name: "index_documents_on_id", unique: true
    t.index ["tax_income_id"], name: "index_documents_on_tax_income_id"
  end

  create_table "estimations", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "first_name"
    t.boolean "first_time", default: false, null: false
    t.integer "home_changes", default: 0, null: false
    t.integer "rentals_mortgages", default: 0, null: false
    t.boolean "professional_company_activity", default: false, null: false
    t.integer "real_state_trade", default: 0, null: false
    t.boolean "with_couple", default: false, null: false
    t.integer "income_rent", default: 0, null: false
    t.integer "shares_trade", default: 0, null: false
    t.boolean "outside_alava", default: false, null: false
    t.integer "price", default: -1, null: false
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_estimations_on_id", unique: true
    t.index ["token"], name: "index_estimations_on_token", unique: true
  end

  create_table "tax_incomes", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "observations"
    t.integer "year"
    t.integer "price", default: -1, null: false
    t.integer "amount_captured", default: -1, null: false
    t.boolean "captured", default: false, null: false
    t.boolean "paid", default: false, null: false
    t.integer "state", default: 0
    t.string "lawyer_id"
    t.string "client_id", null: false
    t.string "estimation_id"
    t.string "payment_intent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_tax_incomes_on_client_id"
    t.index ["estimation_id"], name: "index_tax_incomes_on_estimation_id"
    t.index ["id"], name: "index_tax_incomes_on_id", unique: true
    t.index ["lawyer_id"], name: "index_tax_incomes_on_lawyer_id"
    t.index ["payment_intent_id"], name: "index_tax_incomes_on_payment_intent_id", unique: true
  end

  create_table "users", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "email", default: "", null: false
    t.string "password_digest", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "stripe_customer_id"
    t.datetime "confirmed_at"
    t.string "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "account_type", default: 0
    t.boolean "blocked", default: false, null: false
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["id"], name: "index_users_on_id", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "account_histories", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointments", "tax_incomes"
  add_foreign_key "appointments", "users", column: "client_id"
  add_foreign_key "appointments", "users", column: "lawyer_id"
  add_foreign_key "document_histories", "documents"
  add_foreign_key "document_histories", "users"
  add_foreign_key "documents", "tax_incomes"
  add_foreign_key "documents", "users", column: "exported_by_id"
  add_foreign_key "tax_incomes", "estimations"
  add_foreign_key "tax_incomes", "users", column: "client_id"
  add_foreign_key "tax_incomes", "users", column: "lawyer_id"
end
