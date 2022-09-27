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

ActiveRecord::Schema[7.0].define(version: 2022_09_26_140006) do
  create_table "appointments", force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "lawyer_id", null: false
    t.datetime "time"
    t.integer "tax_income_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "method"
    t.string "phone"
    t.index ["client_id"], name: "index_appointments_on_client_id"
    t.index ["lawyer_id"], name: "index_appointments_on_lawyer_id"
    t.index ["tax_income_id"], name: "index_appointments_on_tax_income_id"
  end

  create_table "estimations", force: :cascade do |t|
    t.string "first_name"
    t.boolean "first_time"
    t.integer "home_changes"
    t.integer "rentals_mortgages"
    t.boolean "professional_company_activity"
    t.integer "real_state_trade"
    t.boolean "with_couple"
    t.integer "income_rent"
    t.integer "shares_trade"
    t.boolean "outside_alava"
    t.float "price"
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
    t.float "price"
    t.string "observations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state", default: 0
    t.integer "lawyer_id"
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
    t.string "name"
    t.string "surname"
    t.string "phone"
    t.integer "account_type", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "appointments", "tax_incomes"
  add_foreign_key "appointments", "users", column: "client_id"
  add_foreign_key "appointments", "users", column: "lawyer_id"
  add_foreign_key "estimations", "tax_incomes"
  add_foreign_key "estimations", "users"
  add_foreign_key "tax_incomes", "users"
  add_foreign_key "tax_incomes", "users", column: "lawyer_id"
end
