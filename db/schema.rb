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

ActiveRecord::Schema.define(version: 20200112222959) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attempt_choices", force: :cascade do |t|
    t.bigint "attempt_id"
    t.bigint "question_id"
    t.bigint "choice_id"
    t.bigint "user_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attempt_id"], name: "index_attempt_choices_on_attempt_id"
    t.index ["choice_id"], name: "index_attempt_choices_on_choice_id"
    t.index ["question_id"], name: "index_attempt_choices_on_question_id"
    t.index ["team_id"], name: "index_attempt_choices_on_team_id"
    t.index ["user_id"], name: "index_attempt_choices_on_user_id"
  end

  create_table "attempts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.bigint "quiz_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points", default: 0
    t.boolean "team_attempt", default: false
    t.index ["quiz_id"], name: "index_attempts_on_quiz_id"
    t.index ["team_id"], name: "index_attempts_on_team_id"
    t.index ["user_id"], name: "index_attempts_on_user_id"
  end

  create_table "choices", force: :cascade do |t|
    t.text "choice_body"
    t.boolean "correct"
    t.bigint "quiz_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "question_id"
    t.index ["question_id"], name: "index_choices_on_question_id"
    t.index ["quiz_id"], name: "index_choices_on_quiz_id"
  end

  create_table "course_options", force: :cascade do |t|
    t.boolean "randomize_questions", default: false
    t.boolean "randomize_answers", default: false
    t.boolean "show_all_questions", default: true
    t.boolean "active", default: true
    t.integer "duration"
    t.bigint "course_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_options_on_course_id"
    t.index ["user_id"], name: "index_course_options_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["user_id"], name: "index_enrollments_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "body"
    t.bigint "quiz_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "course_id"
    t.datetime "due_date"
    t.boolean "randomize_questions", default: false
    t.boolean "randomize_answers", default: false
    t.boolean "show_all_questions", default: true
    t.boolean "active", default: true
    t.index ["course_id"], name: "index_quizzes_on_course_id"
    t.index ["user_id"], name: "index_quizzes_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_teams_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.string "username"
    t.bigint "team_id"
    t.integer "studentid"
    t.string "firstname"
    t.string "lastname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  add_foreign_key "attempt_choices", "attempts"
  add_foreign_key "attempt_choices", "choices"
  add_foreign_key "attempt_choices", "questions"
  add_foreign_key "attempt_choices", "teams"
  add_foreign_key "attempt_choices", "users"
  add_foreign_key "attempts", "quizzes"
  add_foreign_key "attempts", "teams"
  add_foreign_key "attempts", "users"
  add_foreign_key "choices", "questions"
  add_foreign_key "choices", "quizzes"
  add_foreign_key "course_options", "courses"
  add_foreign_key "course_options", "users"
  add_foreign_key "courses", "users"
  add_foreign_key "enrollments", "courses"
  add_foreign_key "questions", "quizzes"
  add_foreign_key "quizzes", "courses"
  add_foreign_key "quizzes", "users"
  add_foreign_key "teams", "courses"
  add_foreign_key "users", "teams"
end
