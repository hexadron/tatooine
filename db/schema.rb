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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121201103430) do

  create_table "achievements", :force => true do |t|
    t.integer  "course_id"
    t.integer  "evaluation_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "achievements", ["course_id"], :name => "index_achievements_on_course_id"
  add_index "achievements", ["evaluation_id"], :name => "index_achievements_on_evaluation_id"

  create_table "badges", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "evaluation_id"
    t.integer  "course_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "badges", ["course_id"], :name => "index_badges_on_course_id"
  add_index "badges", ["evaluation_id"], :name => "index_badges_on_evaluation_id"

  create_table "course_sessions", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "division_id"
    t.integer  "course_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "course_sessions", ["course_id"], :name => "index_course_sessions_on_course_id"
  add_index "course_sessions", ["division_id"], :name => "index_course_sessions_on_division_id"

  create_table "courses", :force => true do |t|
    t.string   "difficulty"
    t.string   "name"
    t.date     "available_at"
    t.boolean  "can_be_published"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "divisions", :force => true do |t|
    t.integer  "level"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "divisions", ["course_id"], :name => "index_divisions_on_course_id"

  create_table "enrollments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "enrollments", ["course_id"], :name => "index_enrollments_on_course_id"
  add_index "enrollments", ["user_id"], :name => "index_enrollments_on_user_id"

  create_table "evaluations", :force => true do |t|
    t.integer  "session_part_id"
    t.integer  "course_session_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "evaluations", ["course_session_id"], :name => "index_evaluations_on_course_session_id"
  add_index "evaluations", ["session_part_id"], :name => "index_evaluations_on_session_part_id"

  create_table "exercise_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "exercises", :force => true do |t|
    t.text     "question"
    t.text     "result"
    t.integer  "exercise_type_id"
    t.integer  "evaluation_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "exercises", ["evaluation_id"], :name => "index_exercises_on_evaluation_id"
  add_index "exercises", ["exercise_type_id"], :name => "index_exercises_on_exercise_type_id"

  create_table "session_parts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "course_session_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "session_parts", ["course_session_id"], :name => "index_session_parts_on_course_session_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end