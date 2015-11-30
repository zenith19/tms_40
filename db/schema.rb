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

ActiveRecord::Schema.define(version: 20151130071733) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "activity_type", limit: 4
    t.integer  "target_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.date     "start_date"
    t.date     "end_date"
    t.date     "finished"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "courses_subjects", force: :cascade do |t|
    t.integer  "course_id",  limit: 4
    t.integer  "subject_id", limit: 4
    t.date     "deadline"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "courses_subjects", ["course_id"], name: "index_courses_subjects_on_course_id", using: :btree
  add_index "courses_subjects", ["subject_id"], name: "index_courses_subjects_on_subject_id", using: :btree

  create_table "courses_subjects_tasks", force: :cascade do |t|
    t.integer  "courses_subject_id", limit: 4
    t.integer  "task_id",            limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "courses_subjects_tasks", ["courses_subject_id"], name: "index_courses_subjects_tasks_on_courses_subject_id", using: :btree
  add_index "courses_subjects_tasks", ["task_id"], name: "index_courses_subjects_tasks_on_task_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname",       limit: 255
    t.string   "lastname",        limit: 255
    t.string   "email",           limit: 255
    t.text     "password_digest", limit: 65535
    t.text     "remember_digest", limit: 65535
    t.boolean  "supervisor"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "users_courses", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "course_id",  limit: 4
    t.boolean  "removed"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "users_courses", ["course_id"], name: "index_users_courses_on_course_id", using: :btree
  add_index "users_courses", ["user_id"], name: "index_users_courses_on_user_id", using: :btree

  create_table "users_subjects", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "subject_id", limit: 4
    t.boolean  "finished"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "users_subjects", ["subject_id"], name: "index_users_subjects_on_subject_id", using: :btree
  add_index "users_subjects", ["user_id"], name: "index_users_subjects_on_user_id", using: :btree

  create_table "users_tasks", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "task_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "users_tasks", ["task_id"], name: "index_users_tasks_on_task_id", using: :btree
  add_index "users_tasks", ["user_id"], name: "index_users_tasks_on_user_id", using: :btree

  add_foreign_key "activities", "users"
  add_foreign_key "courses_subjects", "courses"
  add_foreign_key "courses_subjects", "subjects"
  add_foreign_key "courses_subjects_tasks", "courses_subjects"
  add_foreign_key "courses_subjects_tasks", "tasks"
  add_foreign_key "users_courses", "courses"
  add_foreign_key "users_courses", "users"
  add_foreign_key "users_subjects", "subjects"
  add_foreign_key "users_subjects", "users"
  add_foreign_key "users_tasks", "tasks"
  add_foreign_key "users_tasks", "users"
end
