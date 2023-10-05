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

ActiveRecord::Schema[7.0].define(version: 2023_10_05_160746) do
  create_table "academics", force: :cascade do |t|
    t.string "name"
    t.integer "staff_report_id"
    t.integer "subject_report_id"
    t.integer "faculty_report_id"
    t.integer "teacher_report_id"
    t.string "report_type"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faculties", force: :cascade do |t|
    t.string "name"
    t.integer "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.boolean "have_read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "report_details", force: :cascade do |t|
    t.text "report_value", null: false
    t.string "report_keys", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "report_id"
    t.index ["report_id"], name: "index_report_details_on_report_id"
  end

  create_table "report_templates", force: :cascade do |t|
    t.datetime "apply_time"
    t.boolean "is_apply"
    t.integer "uid"
    t.integer "academic_year_id"
    t.integer "subject_id"
    t.date "deadline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "data"
    t.string "name"
    t.string "year"
    t.string "role"
  end

  create_table "reports", force: :cascade do |t|
    t.datetime "last_submit_time"
    t.datetime "confirm_time"
    t.datetime "return_time"
    t.string "status", default: "shopper", null: false
    t.integer "submiter_id"
    t.integer "returner_id"
    t.string "report_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.text "data"
    t.string "year"
    t.string "role"
    t.string "name"
    t.bigint "report_template_id"
    t.index ["report_template_id"], name: "index_reports_on_report_template_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.integer "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "role"
    t.bigint "faculty_id"
    t.bigint "subject_id"
    t.string "phone_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["faculty_id"], name: "index_users_on_faculty_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["subject_id"], name: "index_users_on_subject_id"
  end

end
