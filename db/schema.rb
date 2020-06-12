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

ActiveRecord::Schema.define(version: 2020_06_11_234235) do

  create_table "courses", force: :cascade do |t|
    t.integer "teacher_id", null: false
    t.integer "level_id", null: false
    t.integer "schedule_id", null: false
    t.integer "modality_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["level_id"], name: "index_courses_on_level_id"
    t.index ["modality_id"], name: "index_courses_on_modality_id"
    t.index ["schedule_id"], name: "index_courses_on_schedule_id"
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "day_of_the_weeks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "modalities", force: :cascade do |t|
    t.string "name"
    t.integer "max_students"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "hour"
    t.integer "day_of_the_week_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["day_of_the_week_id"], name: "index_schedules_on_day_of_the_week_id"
  end

  create_table "student_in_courses", force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_student_in_courses_on_course_id"
    t.index ["student_id"], name: "index_student_in_courses_on_student_id"
  end

  create_table "student_schedules", force: :cascade do |t|
    t.integer "schedule_id", null: false
    t.integer "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["schedule_id"], name: "index_student_schedules_on_schedule_id"
    t.index ["student_id"], name: "index_student_schedules_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.integer "level_id", null: false
    t.integer "modality_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["level_id"], name: "index_students_on_level_id"
    t.index ["modality_id"], name: "index_students_on_modality_id"
  end

  create_table "teacher_schedules", force: :cascade do |t|
    t.integer "schedule_id", null: false
    t.integer "teacher_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["schedule_id"], name: "index_teacher_schedules_on_schedule_id"
    t.index ["teacher_id"], name: "index_teacher_schedules_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "courses", "levels"
  add_foreign_key "courses", "modalities"
  add_foreign_key "courses", "schedules"
  add_foreign_key "courses", "teachers"
  add_foreign_key "schedules", "day_of_the_weeks"
  add_foreign_key "student_in_courses", "courses"
  add_foreign_key "student_in_courses", "students"
  add_foreign_key "student_schedules", "schedules"
  add_foreign_key "student_schedules", "students"
  add_foreign_key "students", "levels"
  add_foreign_key "students", "modalities"
  add_foreign_key "teacher_schedules", "schedules"
  add_foreign_key "teacher_schedules", "teachers"
end
