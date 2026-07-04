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

ActiveRecord::Schema[8.1].define(version: 2026_06_28_182329) do
  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.integer "task_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["task_id"], name: "index_comments_on_task_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "task_changelogs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "task_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["task_id"], name: "index_task_changelogs_on_task_id"
    t.index ["user_id"], name: "index_task_changelogs_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "assignee_id"
    t.integer "author_id", null: false
    t.datetime "created_at", null: false
    t.string "description"
    t.integer "team_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["assignee_id"], name: "index_tasks_on_assignee_id"
    t.index ["author_id"], name: "index_tasks_on_author_id"
    t.index ["team_id"], name: "index_tasks_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "user_teams", primary_key: ["user_id", "team_id"], force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "role", default: 1
    t.integer "team_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["team_id"], name: "index_user_teams_on_team_id"
    t.index ["user_id"], name: "index_user_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "comments", "tasks", on_delete: :cascade
  add_foreign_key "comments", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "task_changelogs", "tasks", on_delete: :cascade
  add_foreign_key "task_changelogs", "users"
  add_foreign_key "tasks", "teams", on_delete: :cascade
  add_foreign_key "tasks", "users", column: "assignee_id"
  add_foreign_key "tasks", "users", column: "author_id"
  add_foreign_key "user_teams", "teams", on_delete: :cascade
  add_foreign_key "user_teams", "users", on_delete: :cascade
end
