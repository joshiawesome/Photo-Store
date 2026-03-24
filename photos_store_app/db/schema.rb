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

ActiveRecord::Schema[8.1].define(version: 2026_03_24_112536) do
  create_table "additional_informations", force: :cascade do |t|
    t.text "body_html"
    t.datetime "created_at", null: false
    t.string "info_type"
    t.string "product_id"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "images", id: :string, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "height"
    t.string "imageable_id"
    t.string "imageable_type"
    t.string "transformed_url"
    t.datetime "updated_at", null: false
    t.string "url"
    t.integer "width"
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"
  end

  create_table "photos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "external_id"
    t.string "image_url"
    t.string "name"
    t.decimal "price"
    t.datetime "updated_at", null: false
  end

  create_table "products", id: :string, force: :cascade do |t|
    t.string "access"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.string "slug"
    t.string "state"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "password_digest"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "variant_attributes", force: :cascade do |t|
    t.string "color_name"
    t.string "color_swatch"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "size_name"
    t.datetime "updated_at", null: false
    t.string "variant_id", null: false
  end

  create_table "variants", id: :string, force: :cascade do |t|
    t.string "compare_at_price_currency"
    t.decimal "compare_at_price_value"
    t.datetime "created_at", null: false
    t.string "dimension_unit"
    t.decimal "height"
    t.decimal "length"
    t.string "name"
    t.string "price_currency"
    t.decimal "price_value"
    t.string "product_id"
    t.string "sku"
    t.string "stock_type"
    t.datetime "updated_at", null: false
    t.string "weight_unit"
    t.decimal "weight_value"
    t.decimal "width"
  end

  add_foreign_key "additional_informations", "products"
  add_foreign_key "variant_attributes", "variants"
  add_foreign_key "variants", "products"
end
