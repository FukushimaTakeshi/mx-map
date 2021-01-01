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

ActiveRecord::Schema.define(version: 2020_12_31_132158) do

  create_table "active_admin_comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
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
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "favorite_courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "off_road_circuit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["off_road_circuit_id"], name: "index_favorite_courses_on_off_road_circuit_id"
    t.index ["user_id"], name: "index_favorite_courses_on_user_id"
  end

  create_table "licenses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "mx_class"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mx_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "history"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mx_profiles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "mx_history_id"
    t.bigint "license_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["license_id"], name: "index_mx_profiles_on_license_id"
    t.index ["mx_history_id"], name: "index_mx_profiles_on_mx_history_id"
    t.index ["user_id"], name: "index_mx_profiles_on_user_id"
  end

  create_table "off_road_circuits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "url"
    t.bigint "prefecture_id"
    t.bigint "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "place_id"
    t.index ["prefecture_id"], name: "index_off_road_circuits_on_prefecture_id"
    t.index ["region_id"], name: "index_off_road_circuits_on_region_id"
  end

  create_table "photos", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "url"
    t.bigint "off_road_circuit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["off_road_circuit_id"], name: "index_photos_on_off_road_circuit_id"
  end

  create_table "plans", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "date"
    t.bigint "off_road_circuit_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.bigint "user_id"
    t.index ["date", "uuid", "off_road_circuit_id"], name: "unique_date_uuid_circuit", unique: true
    t.index ["off_road_circuit_id"], name: "index_plans_on_off_road_circuit_id"
    t.index ["user_id"], name: "index_plans_on_user_id"
  end

  create_table "practice_recodes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "off_road_circuit_id"
    t.bigint "user_id"
    t.date "practice_date"
    t.string "comment"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["off_road_circuit_id"], name: "index_practice_recodes_on_off_road_circuit_id"
    t.index ["user_id", "practice_date"], name: "unique_user_date", unique: true
    t.index ["user_id"], name: "index_practice_recodes_on_user_id"
  end

  create_table "prefectures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.bigint "region_id"
    t.index ["region_id"], name: "index_prefectures_on_region_id"
  end

  create_table "regions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
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
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.boolean "admin", default: false, null: false
    t.string "avatar"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "favorite_courses", "off_road_circuits"
  add_foreign_key "favorite_courses", "users"
  add_foreign_key "mx_profiles", "licenses"
  add_foreign_key "mx_profiles", "mx_histories"
  add_foreign_key "mx_profiles", "users"
  add_foreign_key "off_road_circuits", "prefectures"
  add_foreign_key "off_road_circuits", "regions"
  add_foreign_key "photos", "off_road_circuits"
  add_foreign_key "plans", "off_road_circuits"
  add_foreign_key "plans", "users"
  add_foreign_key "practice_recodes", "off_road_circuits"
  add_foreign_key "practice_recodes", "users"
  add_foreign_key "prefectures", "regions"
end
