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

ActiveRecord::Schema[7.2].define(version: 2026_02_27_000001) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "assets", id: :serial, force: :cascade do |t|
    t.string "type", limit: 255
    t.string "asset", limit: 255
    t.string "checksum", limit: 255
    t.string "path", limit: 255
    t.integer "filesize"
    t.integer "width"
    t.integer "height"
    t.integer "duration"
    t.integer "bit_rate"
    t.integer "assetable_id"
    t.string "assetable_type", limit: 255
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "position"
    t.boolean "cover"
    t.string "title", limit: 255
    t.text "description"
    t.string "caption", limit: 255
    t.index ["assetable_id", "assetable_type"], name: "index_assets_on_assetable_id_and_assetable_type"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description"
    t.integer "post_count"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "slug", limit: 255
    t.integer "position", default: 0, null: false
    t.index ["post_count"], name: "index_categories_on_post_count"
  end

  create_table "categorizations", id: false, force: :cascade do |t|
    t.integer "post_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_categorizations_on_category_id"
    t.index ["post_id"], name: "index_categorizations_on_post_id"
  end

  create_table "category_connections", id: :serial, force: :cascade do |t|
    t.integer "category_id"
    t.integer "connectable_id"
    t.string "connectable_type", limit: 255
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["category_id"], name: "index_category_connections_on_category_id"
    t.index ["connectable_id", "connectable_type"], name: "category_connection"
  end

  create_table "countries", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "code", limit: 255
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["code"], name: "index_countries_on_code"
  end

  create_table "experiences", id: :serial, force: :cascade do |t|
    t.integer "location_id", null: false
    t.string "name", limit: 255, null: false
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.float "distance"
    t.integer "votes_cache", default: 0, null: false
    t.string "slug", limit: 255
    t.boolean "done", default: false, null: false
    t.index ["location_id"], name: "index_experiences_on_location_id"
    t.index ["slug"], name: "index_experiences_on_slug"
    t.index ["user_id"], name: "index_experiences_on_user_id"
  end

  create_table "experiences_posts", id: false, force: :cascade do |t|
    t.integer "experience_id"
    t.integer "post_id"
    t.index ["experience_id"], name: "index_experiences_posts_on_experience_id"
    t.index ["post_id"], name: "index_experiences_posts_on_post_id"
  end

  create_table "locations", id: :serial, force: :cascade do |t|
    t.float "lat", null: false
    t.float "long", null: false
    t.string "name", limit: 255
    t.string "address", limit: 255
    t.string "city", limit: 255
    t.integer "state_id"
    t.integer "zip"
    t.integer "country_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "done", default: false, null: false
    t.string "formatted_address", limit: 255
    t.boolean "current", default: false, null: false
    t.integer "experiences_count", default: 0
    t.integer "votes_cache", default: 0, null: false
    t.index ["country_id"], name: "index_locations_on_country_id"
    t.index ["state_id"], name: "index_locations_on_state_id"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.integer "user_id", default: 1, null: false
    t.text "body"
    t.string "subtitle", limit: 255
    t.datetime "published_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "slug", limit: 255, null: false
    t.text "excerpt"
    t.boolean "published", default: false, null: false
    t.index ["published_at", "published"], name: "index_posts_on_published_at_and_published"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "resource_id"
    t.string "resource_type", limit: 255
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "states", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "abbr", limit: 255
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "done"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "provider", limit: 255
    t.string "email", limit: 255, default: ""
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "uid", limit: 255
    t.string "location", limit: 255
    t.string "username", limit: 255
    t.integer "timezone"
    t.boolean "mailing_list"
    t.string "uuid", limit: 255
    t.text "referring_url"
    t.text "landing_url"
    t.string "authentication_token", limit: 255
    t.boolean "guest", default: false, null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "votable_type"
    t.integer "votable_id"
    t.integer "value", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id", "votable_id", "votable_type"], name: "index_votes_on_user_and_votable", unique: true
    t.index ["user_id"], name: "index_votes_on_user_id"
    t.index ["votable_type", "votable_id"], name: "index_votes_on_votable_type_and_votable_id"
  end
end
