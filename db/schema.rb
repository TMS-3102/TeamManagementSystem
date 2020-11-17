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

ActiveRecord::Schema.define(version: 20201117220845) do

  create_table "courses", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "name"
    t.string   "code"
    t.integer  "instructor_id"
  end

  create_table "courses_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
    t.index ["course_id"], name: "index_courses_users_on_course_id"
    t.index ["user_id"], name: "index_courses_users_on_user_id"
  end

  create_table "message_boards", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "number_stored"
    t.integer  "team_id"
  end

  create_table "messages", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "title"
    t.date     "post_date"
    t.integer  "priority"
    t.text     "content"
    t.integer  "message_board_id"
    t.string   "name"
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "team_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "description"
    t.boolean  "completed",   default: false
    t.string   "title"
    t.date     "deadline"
    t.integer  "order"
    t.integer  "priority"
    t.integer  "team_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "name"
    t.integer  "liaison_id"
    t.integer  "maximum_capacity"
    t.integer  "minimum_capacity"
    t.date     "deadline"
    t.boolean  "status"
    t.integer  "course_id"
  end

  create_table "teams_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "team_id"
    t.index ["team_id"], name: "index_teams_users_on_team_id"
    t.index ["user_id"], name: "index_teams_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.boolean  "is_student",             default: false
    t.integer  "identification_number"
    t.boolean  "is_liaison",             default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
