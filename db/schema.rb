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

ActiveRecord::Schema[7.0].define(version: 2023_02_04_084731) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "account_authentication_audit_logs", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.datetime "at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.text "message", null: false
    t.jsonb "metadata"
    t.index ["account_id", "at"], name: "audit_account_at_idx"
    t.index ["account_id"], name: "index_account_authentication_audit_logs_on_account_id"
    t.index ["at"], name: "audit_at_idx"
  end

  create_table "account_email_auth_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "account_histories", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "ip"
    t.datetime "time", null: false
    t.integer "action", null: false
    t.string "user_id", null: false
    t.index ["id"], name: "index_account_histories_on_id", unique: true
    t.index ["user_id"], name: "index_account_histories_on_user_id"
  end

  create_table "account_lockouts", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
    t.datetime "email_last_sent"
  end

  create_table "account_login_change_keys", force: :cascade do |t|
    t.string "key", null: false
    t.string "login", null: false
    t.datetime "deadline", null: false
  end

  create_table "account_login_failures", force: :cascade do |t|
    t.integer "number", default: 1, null: false
  end

  create_table "account_otp_keys", force: :cascade do |t|
    t.string "key", null: false
    t.integer "num_failures", default: 0, null: false
    t.datetime "last_use", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "account_password_reset_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "account_recovery_codes", primary_key: ["id", "code"], force: :cascade do |t|
    t.bigint "id", null: false
    t.string "code", null: false
  end

  create_table "account_remember_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "deadline", null: false
  end

  create_table "account_verification_keys", force: :cascade do |t|
    t.string "key", null: false
    t.datetime "requested_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "email_last_sent", default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "account_webauthn_keys", primary_key: ["account_id", "webauthn_id"], force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "webauthn_id", null: false
    t.string "public_key", null: false
    t.integer "sign_count", null: false
    t.datetime "last_use", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["account_id"], name: "index_account_webauthn_keys_on_account_id"
  end

  create_table "account_webauthn_user_ids", force: :cascade do |t|
    t.string "webauthn_id", null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.integer "status", default: 1, null: false
    t.citext "email", null: false
    t.string "password_hash"
    t.index ["email"], name: "index_accounts_on_email", unique: true, where: "(status = ANY (ARRAY[1, 2]))"
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
    t.string "tax_income_id"
    t.string "lawyer_id"
    t.index ["client_id"], name: "index_appointments_on_client_id"
    t.index ["id"], name: "index_appointments_on_id", unique: true
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

  create_table "lawyer_profiles", id: :string, force: :cascade do |t|
    t.string "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "org_status", default: 0, null: false
    t.integer "lawyer_status", default: 0, null: false
    t.integer "tax_income_count", default: 0
    t.string "organization_id", null: false
    t.index ["organization_id", "user_id"], name: "index_lawyer_profiles_on_organization_id_and_user_id", unique: true
    t.index ["user_id"], name: "index_lawyer_profiles_on_user_id", unique: true
  end

  create_table "organization_stats", id: :string, force: :cascade do |t|
    t.string "organization_id", null: false
    t.integer "lawyers_active_count", default: 0, null: false
    t.integer "lawyers_active_count_acc", default: 0, null: false
    t.integer "lawyers_inactive_count", default: 0, null: false
    t.integer "lawyers_inactive_count_acc", default: 0, null: false
    t.integer "tax_income_count", default: 0, null: false
    t.integer "tax_income_count_acc", default: 0, null: false
    t.integer "tax_income_finished_count", default: 0, null: false
    t.integer "tax_income_finished_count_acc", default: 0, null: false
    t.integer "tax_income_pending_count", default: 0, null: false
    t.integer "tax_income_pending_count_acc", default: 0, null: false
    t.integer "one_star_count", default: 0, null: false
    t.integer "one_star_count_acc", default: 0, null: false
    t.integer "two_star_count", default: 0, null: false
    t.integer "two_star_count_acc", default: 0, null: false
    t.integer "three_star_count", default: 0, null: false
    t.integer "three_star_count_acc", default: 0, null: false
    t.integer "four_star_count", default: 0, null: false
    t.integer "four_star_count_acc", default: 0, null: false
    t.integer "five_star_count", default: 0, null: false
    t.integer "five_star_count_acc", default: 0, null: false
    t.integer "avg_rating_today", default: 0, null: false
    t.integer "balance_today", default: 0
    t.date "date"
    t.index ["organization_id", "date"], name: "index_organization_stats_on_organization_id_and_date", unique: true
    t.index ["organization_id"], name: "index_organization_stats_on_organization_id"
  end

  create_table "organizations", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "phone", null: false
    t.string "email", null: false
    t.string "website", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "owner_id", null: false
    t.jsonb "prices", default: {}
    t.float "latitude", default: 0.0, null: false
    t.float "longitude", default: 0.0, null: false
    t.integer "price_range"
    t.integer "tax_income_count", default: 0
    t.integer "five_star_count", default: 0
    t.integer "four_star_count", default: 0
    t.integer "three_star_count", default: 0
    t.integer "two_star_count", default: 0
    t.integer "one_star_count", default: 0
    t.string "location"
    t.string "province", default: ""
    t.string "city", default: ""
    t.string "street", default: ""
    t.string "postal_code", default: ""
    t.string "country", default: ""
    t.string "subscription_id"
    t.integer "status", default: 0
    t.integer "app_fee", default: 10
    t.index ["latitude", "longitude"], name: "index_organizations_on_latitude_and_longitude"
    t.index ["owner_id"], name: "index_organizations_on_owner_id"
  end

  create_table "reviews", id: :string, force: :cascade do |t|
    t.integer "rating", null: false
    t.datetime "created_at", null: false
    t.string "organization_id", null: false
    t.string "comment", default: ""
    t.string "user_id", null: false
    t.string "tax_income_id"
    t.index ["organization_id", "user_id"], name: "index_reviews_on_organization_id_and_user_id", unique: true
    t.index ["organization_id"], name: "index_reviews_on_organization_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
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
    t.string "client_id", null: false
    t.string "estimation_id"
    t.string "payment_intent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lawyer_id"
    t.string "organization_id", null: false
    t.index ["client_id"], name: "index_tax_incomes_on_client_id"
    t.index ["estimation_id"], name: "index_tax_incomes_on_estimation_id"
    t.index ["id"], name: "index_tax_incomes_on_id", unique: true
    t.index ["organization_id"], name: "index_tax_incomes_on_organization_id"
    t.index ["payment_intent_id"], name: "index_tax_incomes_on_payment_intent_id", unique: true
  end

  create_table "transactions", id: :string, force: :cascade do |t|
    t.string "user_id", null: false
    t.string "organization_id", null: false
    t.string "payment_intent_id", null: false
    t.string "status", null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.integer "amount", null: false
    t.integer "amount_capturable", null: false
    t.index ["organization_id"], name: "index_transactions_on_organization_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", id: false, force: :cascade do |t|
    t.string "id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "stripe_customer_id"
    t.integer "account_type", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["id"], name: "index_users_on_id", unique: true
  end

  add_foreign_key "account_authentication_audit_logs", "accounts"
  add_foreign_key "account_histories", "users"
  add_foreign_key "account_lockouts", "accounts", column: "id"
  add_foreign_key "account_login_change_keys", "accounts", column: "id"
  add_foreign_key "account_login_failures", "accounts", column: "id"
  add_foreign_key "account_otp_keys", "accounts", column: "id"
  add_foreign_key "account_password_reset_keys", "accounts", column: "id"
  add_foreign_key "account_recovery_codes", "accounts", column: "id"
  add_foreign_key "account_remember_keys", "accounts", column: "id"
  add_foreign_key "account_verification_keys", "accounts", column: "id"
  add_foreign_key "account_webauthn_keys", "accounts"
  add_foreign_key "account_webauthn_user_ids", "accounts", column: "id"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointments", "tax_incomes"
  add_foreign_key "appointments", "users", column: "client_id"
  add_foreign_key "document_histories", "documents"
  add_foreign_key "document_histories", "users"
  add_foreign_key "documents", "tax_incomes"
  add_foreign_key "documents", "users", column: "exported_by_id"
  add_foreign_key "lawyer_profiles", "organizations"
  add_foreign_key "organizations", "users", column: "owner_id"
  add_foreign_key "tax_incomes", "estimations"
  add_foreign_key "tax_incomes", "users", column: "client_id"
  add_foreign_key "users", "accounts"
end
