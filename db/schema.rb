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

ActiveRecord::Schema[7.1].define(version: 2024_07_01_111634) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_years", force: :cascade do |t|
    t.integer "year", null: false
  end

  create_table "appropriate_bodies", force: :cascade do |t|
    t.string "name"
  end

  create_table "declarations", force: :cascade do |t|
    t.bigint "training_period_id"
    t.string "declaration_type"
    t.index ["training_period_id"], name: "index_declarations_on_training_period_id"
  end

  create_table "delivery_partners", force: :cascade do |t|
    t.string "name"
  end

  create_table "ect_at_school_periods", force: :cascade do |t|
    t.bigint "school_id"
    t.bigint "teacher_id"
    t.date "started_on", null: false
    t.date "finished_on"
    t.index "school_id, teacher_id, ((finished_on IS NULL))", name: "idx_on_school_id_teacher_id_finished_on_IS_NULL_abe4626dca", unique: true, where: "(finished_on IS NULL)"
    t.index ["school_id"], name: "index_ect_at_school_periods_on_school_id"
    t.index ["teacher_id"], name: "index_ect_at_school_periods_on_teacher_id"
  end

  create_table "induction_periods", force: :cascade do |t|
    t.bigint "ect_at_school_period_id"
    t.bigint "appropriate_body_id"
    t.date "started_on", null: false
    t.date "finished_on"
    t.index "ect_at_school_period_id, ((finished_on IS NULL))", name: "idx_on_ect_at_school_period_id_finished_on_IS_NULL_be6c214e9d", unique: true, where: "(finished_on IS NULL)"
    t.index ["appropriate_body_id"], name: "index_induction_periods_on_appropriate_body_id"
    t.index ["ect_at_school_period_id"], name: "index_induction_periods_on_ect_at_school_period_id"
  end

  create_table "lead_providers", force: :cascade do |t|
    t.string "name"
  end

  create_table "mentor_at_school_periods", force: :cascade do |t|
    t.bigint "school_id"
    t.bigint "teacher_id"
    t.date "started_on", null: false
    t.date "finished_on"
    t.index "school_id, teacher_id, ((finished_on IS NULL))", name: "idx_on_school_id_teacher_id_finished_on_IS_NULL_dd7ee16a28", unique: true, where: "(finished_on IS NULL)"
    t.index ["school_id"], name: "index_mentor_at_school_periods_on_school_id"
    t.index ["teacher_id"], name: "index_mentor_at_school_periods_on_teacher_id"
  end

  create_table "mentorship_periods", force: :cascade do |t|
    t.bigint "ect_at_school_period_id"
    t.bigint "mentor_at_school_period_id"
    t.date "started_on", null: false
    t.date "finished_on"
    t.index "ect_at_school_period_id, mentor_at_school_period_id, ((finished_on IS NULL))", name: "idx_on_ect_at_school_period_id_mentor_at_school_per_482f52b217", unique: true, where: "(finished_on IS NULL)"
    t.index ["ect_at_school_period_id"], name: "index_mentorship_periods_on_ect_at_school_period_id"
    t.index ["mentor_at_school_period_id"], name: "index_mentorship_periods_on_mentor_at_school_period_id"
  end

  create_table "provider_partnerships", force: :cascade do |t|
    t.bigint "academic_year_id"
    t.bigint "lead_provider_id"
    t.bigint "delivery_partner_id"
    t.index ["academic_year_id"], name: "index_provider_partnerships_on_academic_year_id"
    t.index ["delivery_partner_id"], name: "index_provider_partnerships_on_delivery_partner_id"
    t.index ["lead_provider_id"], name: "index_provider_partnerships_on_lead_provider_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name"
  end

  create_table "training_periods", force: :cascade do |t|
    t.bigint "provider_partnership_id"
    t.bigint "ect_at_school_period_id"
    t.bigint "mentor_at_school_period_id"
    t.date "started_on", null: false
    t.date "finished_on"
    t.index "ect_at_school_period_id, mentor_at_school_period_id, provider_partnership_id, ((finished_on IS NULL))", name: "idx_on_ect_at_school_period_id_mentor_at_school_per_442268543c", unique: true, where: "(finished_on IS NULL)"
    t.index ["ect_at_school_period_id"], name: "index_training_periods_on_ect_at_school_period_id"
    t.index ["mentor_at_school_period_id"], name: "index_training_periods_on_mentor_at_school_period_id"
    t.index ["provider_partnership_id"], name: "index_training_periods_on_provider_partnership_id"
  end

end
