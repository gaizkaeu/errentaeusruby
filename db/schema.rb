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

ActiveRecord::Schema[7.0].define(version: 2023_05_04_200405) do
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

  create_table "account_identities", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.json "info", default: "{}"
    t.json "credentials", default: "{}"
    t.json "extra", default: "{}"
    t.index ["account_id"], name: "index_account_identities_on_account_id"
    t.index ["provider", "uid"], name: "index_account_identities_on_provider_and_uid", unique: true
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
    t.string "user_id"
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
    t.string "user_id"
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

  create_table "bulk_calculations", id: :string, force: :cascade do |t|
    t.jsonb "input", default: {}, null: false
    t.string "user_id", null: false
    t.string "calculation_topic_id", null: false
    t.index ["calculation_topic_id"], name: "index_bulk_calculations_on_calculation_topic_id"
    t.index ["user_id"], name: "index_bulk_calculations_on_user_id"
  end

  create_table "calculation_topics", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "prediction_attributes", default: {}
    t.string "validation_file"
    t.string "colors", default: "bg-gradient-to-r from-pink-500 via-red-500 to-yellow-500"
    t.string "description"
  end

  create_table "calculations", id: :string, force: :cascade do |t|
    t.string "calculator_id", null: false
    t.string "user_id"
    t.jsonb "input", null: false
    t.jsonb "output", default: {}, null: false
    t.boolean "verified", default: false, null: false
    t.boolean "train_with", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_result"
    t.datetime "predicted_at"
    t.integer "calculator_version", default: 0
    t.string "bulk_calculation_id"
    t.index ["bulk_calculation_id"], name: "index_calculations_on_bulk_calculation_id"
    t.index ["calculator_id"], name: "index_calculations_on_calculator_id"
    t.index ["user_id"], name: "index_calculations_on_user_id"
  end

  create_table "calculators", id: :string, force: :cascade do |t|
    t.string "organization_id", null: false
    t.binary "marshalled_predictor", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "calculation_topic_id", null: false
    t.jsonb "classifications", default: {}
    t.datetime "last_trained_at"
    t.integer "sample_count", default: -1
    t.integer "version", default: 0
    t.text "dot_visualization"
    t.string "calculator_status", default: "error", null: false
    t.index ["calculation_topic_id"], name: "index_calculators_on_calculation_topic_id"
    t.index ["organization_id"], name: "index_calculators_on_organization_id"
  end

  create_table "call_contacts", id: :string, force: :cascade do |t|
    t.string "organization_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number", null: false
    t.string "state", default: "pending", null: false
    t.boolean "successful", default: false, null: false
    t.string "notes"
    t.string "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer "duration", default: -1, null: false
    t.datetime "call_time"
    t.string "calculation_id"
    t.index ["calculation_id"], name: "index_call_contacts_on_calculation_id"
    t.index ["organization_id"], name: "index_call_contacts_on_organization_id"
    t.index ["user_id"], name: "index_call_contacts_on_user_id"
  end

  create_table "email_contacts", id: :string, force: :cascade do |t|
    t.string "organization_id", null: false
    t.string "state", default: "pending", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email", null: false
    t.boolean "successful", default: false, null: false
    t.string "notes"
    t.string "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "calculation_id"
    t.index ["calculation_id"], name: "index_email_contacts_on_calculation_id"
    t.index ["organization_id"], name: "index_email_contacts_on_organization_id"
    t.index ["user_id"], name: "index_email_contacts_on_user_id"
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
    t.string "google_place_id"
    t.boolean "google_place_verified", default: false
    t.jsonb "open_close_hours", default: {"friday"=>{"open"=>"9:00", "close"=>"17:00"}, "monday"=>{"open"=>"9:00", "close"=>"17:00"}, "sunday"=>{"open"=>"closed", "close"=>"closed"}, "tuesday"=>{"open"=>"9:00", "close"=>"17:00"}, "saturday"=>{"open"=>"closed", "close"=>"closed"}, "thursday"=>{"open"=>"9:00", "close"=>"17:00"}, "wednesday"=>{"open"=>"9:00", "close"=>"17:00"}}
    t.index ["latitude", "longitude"], name: "index_organizations_on_latitude_and_longitude"
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
    t.string "hex_color"
    t.string "emoji"
    t.string "dark_hex_color"
    t.bigint "parent_tag_id"
    t.index ["name"], name: "index_tags_on_name", unique: true
    t.index ["parent_tag_id"], name: "index_tags_on_parent_tag_id"
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
  add_foreign_key "account_identities", "accounts", on_delete: :cascade
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
  add_foreign_key "bulk_calculations", "calculation_topics"
  add_foreign_key "bulk_calculations", "users"
  add_foreign_key "calculations", "bulk_calculations"
  add_foreign_key "calculations", "calculators"
  add_foreign_key "calculations", "users"
  add_foreign_key "calculators", "calculation_topics"
  add_foreign_key "calculators", "organizations"
  add_foreign_key "call_contacts", "calculations"
  add_foreign_key "call_contacts", "organizations", on_delete: :cascade
  add_foreign_key "call_contacts", "users", on_delete: :cascade
  add_foreign_key "email_contacts", "calculations"
  add_foreign_key "email_contacts", "organizations", on_delete: :cascade
  add_foreign_key "email_contacts", "users", on_delete: :cascade
  add_foreign_key "organization_invitations", "organizations"
  add_foreign_key "organization_memberships", "organizations"
  add_foreign_key "organization_memberships", "users"
  add_foreign_key "taggings", "tags"
  add_foreign_key "tags", "tags", column: "parent_tag_id"
  add_foreign_key "users", "accounts"
end
