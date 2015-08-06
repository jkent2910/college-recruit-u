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

ActiveRecord::Schema.define(version: 20150806010208) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "college_student_statuses", force: :cascade do |t|
    t.integer  "college_id"
    t.integer  "student_profile_id"
    t.string   "status_name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "college_student_statuses", ["college_id"], name: "index_college_student_statuses_on_college_id", using: :btree
  add_index "college_student_statuses", ["student_profile_id"], name: "index_college_student_statuses_on_student_profile_id", using: :btree

  create_table "colleges", force: :cascade do |t|
    t.string   "name"
    t.string   "college_type"
    t.string   "city"
    t.string   "state"
    t.string   "region"
    t.string   "student_body_size"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "admissions_rep_page"
    t.string   "college_visit_page"
    t.string   "avg_gpa"
    t.string   "avg_act"
    t.string   "avg_sat"
    t.string   "percent_male"
    t.string   "percent_female"
    t.string   "percent_minority"
    t.string   "percent_international"
    t.text     "popular_majors"
    t.string   "number_of_essays"
    t.string   "number_of_recommendations"
    t.string   "spring_deadine"
    t.string   "summer_deadline"
    t.string   "fall_deadline"
    t.string   "early_admissions_deadline"
    t.string   "in_state_tuition"
    t.string   "out_of_state_tuition"
    t.string   "percent_receive_financial_aid"
    t.text     "notable_alumni"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "financial_aid_link"
  end

  create_table "factor_ratings", force: :cascade do |t|
    t.integer  "student_profile_id"
    t.integer  "factor_id"
    t.integer  "importance"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "factor_ratings", ["factor_id"], name: "index_factor_ratings_on_factor_id", using: :btree
  add_index "factor_ratings", ["student_profile_id"], name: "index_factor_ratings_on_student_profile_id", using: :btree

  create_table "factors", force: :cascade do |t|
    t.string "name"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "college_id"
    t.string   "name"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "fan_id"
    t.integer  "fan_of_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.string   "high_school"
    t.string   "graduation_year"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.text     "interests"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "factor_ratings", "factors"
  add_foreign_key "factor_ratings", "student_profiles"
end
