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

ActiveRecord::Schema[7.0].define(version: 2023_03_17_130832) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authorization_keys", force: :cascade do |t|
    t.string "token"
    t.datetime "expiry"
    t.string "authable_type"
    t.bigint "authable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authable_type", "authable_id"], name: "index_authorization_keys_on_authable"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.integer "total_product", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_categories", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_product_categories_on_category_id"
    t.index ["product_id"], name: "index_product_categories_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "purchase_price", default: "0.0"
    t.decimal "rent_price", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rent_charge_type", default: 0
    t.integer "created_by_id"
  end

  create_table "user_products", force: :cascade do |t|
    t.integer "exchange_type", default: 0
    t.datetime "from_date"
    t.datetime "to_date"
    t.bigint "product_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_user_products_on_product_id"
    t.index ["user_id"], name: "index_user_products_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "password_hash"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
