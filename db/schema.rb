# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170309042720) do

  create_table "companies", force: :cascade do |t|
    t.string   "type"
    t.string   "name",       null: false
    t.string   "code",       null: false
    t.boolean  "delete_flg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "companies", ["code"], name: "index_companies_on_code", unique: true
  add_index "companies", ["type"], name: "index_companies_on_type"

  create_table "day_of_work_and_holidays", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "day_type"
    t.string   "title"
    t.date     "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "day_of_work_and_holidays", ["company_id", "day"], name: "index_day_of_work_and_holidays_on_company_id_and_day"

  create_table "houses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "info_for_each_fiscal_years", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.string   "year"
    t.string   "carry_over_paid_leave_count"
    t.string   "carry_over_late_ealy"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "infos", force: :cascade do |t|
    t.text     "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "one_days", force: :cascade do |t|
    t.integer  "roster_id"
    t.integer  "company_id"
    t.string   "situation"
    t.date     "day"
    t.string   "from",          limit: 5
    t.string   "to",            limit: 5
    t.float    "working_hours"
    t.string   "late_early",    limit: 5
    t.string   "house",         limit: 5
    t.string   "note",          limit: 256
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "one_days", ["roster_id"], name: "index_one_days_on_roster_id"

  create_table "rosters", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.string   "year"
    t.string   "month"
    t.string   "status"
    t.string   "memo"
    t.string   "required_work_day"
    t.string   "total_work_day"
    t.string   "required_work_hour"
    t.string   "allowance_hour"
    t.string   "absence"
    t.string   "holiday_work"
    t.string   "home"
    t.string   "paid_holiday"
    t.string   "house_work"
    t.string   "bereavement"
    t.string   "transfer"
    t.string   "business_trip"
    t.string   "drill"
    t.string   "special"
    t.string   "total_hour_working"
    t.string   "total_hour_house"
    t.string   "total_hour_late_early"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "data"
  end

  add_index "rosters", ["company_id", "user_id"], name: "index_rosters_on_company_id_and_user_id"
  add_index "rosters", ["company_id"], name: "index_rosters_on_company_id"
  add_index "rosters", ["user_id"], name: "index_rosters_on_user_id"

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "time_settings", force: :cascade do |t|
    t.integer  "company_id"
    t.string   "base"
    t.string   "work_s",        limit: 5
    t.string   "work_e",        limit: 5
    t.string   "rest_first_s",  limit: 5
    t.string   "rest_first_e",  limit: 5
    t.string   "rest_second_s", limit: 5
    t.string   "rest_second_e", limit: 5
    t.string   "rest_therd_s",  limit: 5
    t.string   "rest_therd_e",  limit: 5
    t.string   "rest_fourth_s", limit: 5
    t.string   "rest_fourth_e", limit: 5
    t.string   "rest_fifth_s",  limit: 5
    t.string   "rest_fifth_e",  limit: 5
    t.string   "rest_sixth_s",  limit: 5
    t.string   "rest_sixth_e",  limit: 5
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "time_settings", ["company_id"], name: "index_time_settings_on_company_id", unique: true

  create_table "users", force: :cascade do |t|
    t.boolean  "admin"
    t.integer  "company_id",                            null: false
    t.string   "name",                                  null: false
    t.integer  "partner_id"
    t.date     "grant_date_of_paid_leave"
    t.string   "email",                    default: "", null: false
    t.string   "encrypted_password",       default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "contact"
    t.string   "emergency_contact"
    t.date     "birthday"
    t.boolean  "reader"
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
