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

ActiveRecord::Schema[7.0].define(version: 2023_03_24_173152) do
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

  create_table "ahoy_events", force: :cascade do |t|
    t.bigint "visit_id"
    t.bigint "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["properties"], name: "index_ahoy_events_on_properties", opclass: :jsonb_path_ops, using: :gin
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.bigint "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.float "latitude"
    t.float "longitude"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_ahoy_visits_on_user_id"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
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
    t.string "email"
    t.string "phone"
    t.boolean "on_duty", default: false
    t.index ["user_id"], name: "index_lawyer_profiles_on_user_id", unique: true
  end

  create_table "organization_invitations", id: :string, force: :cascade do |t|
    t.string "email", null: false
    t.string "token", null: false
    t.string "status", default: "pending", null: false
    t.string "role", default: "lawyer", null: false
    t.string "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email", "organization_id"], name: "index_organization_invitations_on_email_and_organization_id", unique: true
    t.index ["organization_id"], name: "index_organization_invitations_on_organization_id"
    t.index ["token"], name: "index_organization_invitations_on_token", unique: true
  end

  create_table "organization_memberships", id: :string, force: :cascade do |t|
    t.string "user_id"
    t.string "organization_id"
    t.string "role", default: "member", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_organization_memberships_on_organization_id"
    t.index ["user_id", "organization_id"], name: "index_organization_memberships_on_user_id_and_organization_id", unique: true
    t.index ["user_id"], name: "index_organization_memberships_on_user_id"
  end

  create_table "organization_requests", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "website"
    t.string "city"
    t.string "province"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer "balance_capturable_today", default: 0
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
    t.integer "app_fee", default: 10
    t.jsonb "settings", default: {"hireable"=>true}
    t.boolean "visible", default: true
    t.float "avg_rating", default: 0.0
    t.string "status", default: "not_subscribed", null: false
    t.index ["latitude", "longitude"], name: "index_organizations_on_latitude_and_longitude"
  end

  create_table "payouts", id: :string, force: :cascade do |t|
    t.string "organization_id", null: false
    t.integer "amount", null: false
    t.integer "status", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.jsonb "metadata", default: {}, null: false
    t.index "organization_id, EXTRACT(month FROM date)", name: "index_organization_id_uniqueness_month", unique: true
    t.index ["organization_id"], name: "index_payouts_on_organization_id"
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

  create_table "roles", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.string "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.string "taggable_id"
    t.string "tagger_type"
    t.string "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.string "tenant", limit: 128
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger"
    t.index ["tenant"], name: "index_taggings_on_tenant"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
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
    t.jsonb "settings", default: {}
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["id"], name: "index_users_on_id", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.string "user_id", null: false
    t.string "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
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
  add_foreign_key "organization_invitations", "organizations"
  add_foreign_key "organization_memberships", "organizations"
  add_foreign_key "organization_memberships", "users"
  add_foreign_key "taggings", "tags"
  add_foreign_key "tax_incomes", "estimations"
  add_foreign_key "tax_incomes", "users", column: "client_id"
  add_foreign_key "users", "accounts"
end
