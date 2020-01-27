# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_27_030715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advisors", id: :serial, force: :cascade do |t|
    t.string "name", limit: 60, null: false
    t.string "email", limit: 40, null: false
    t.boolean "intern"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_advisors_on_user_id"
  end

  create_table "advisors_projects", id: false, force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "advisor_id", null: false
    t.index ["advisor_id", "project_id"], name: "index_advisors_projects_on_advisor_id_and_project_id"
    t.index ["project_id", "advisor_id"], name: "index_advisors_projects_on_project_id_and_advisor_id"
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "student_1_id"
    t.integer "student_2_id"
  end

  create_table "project_applications", force: :cascade do |t|
    t.integer "group_id"
    t.integer "project_id"
    t.boolean "accepted"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "project_name"
    t.text "project_description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.integer "number"
    t.string "name"
    t.integer "ects"
    t.float "average"
    t.integer "group_id"
    t.integer "project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_students_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "advisors", "users", on_delete: :cascade
  add_foreign_key "advisors_projects", "advisors", on_delete: :cascade
  add_foreign_key "advisors_projects", "projects", on_delete: :cascade
  add_foreign_key "groups", "students", column: "student_1_id", on_delete: :cascade
  add_foreign_key "groups", "students", column: "student_2_id", on_delete: :cascade
  add_foreign_key "project_applications", "groups", on_delete: :cascade
  add_foreign_key "project_applications", "projects", on_delete: :cascade
  add_foreign_key "students", "users", on_delete: :cascade
end
