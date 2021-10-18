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

ActiveRecord::Schema.define(version: 2021_10_18_042819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "awards", force: :cascade do |t|
    t.integer "amount"
    t.string "purpose"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "funder_id"
    t.bigint "recipient_id"
    t.index ["funder_id"], name: "index_awards_on_funder_id"
    t.index ["recipient_id"], name: "index_awards_on_recipient_id"
  end

  create_table "funders", force: :cascade do |t|
    t.integer "ein"
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type"
    t.index ["ein", "type"], name: "index_funders_on_ein_and_type", unique: true
    t.index ["ein"], name: "index_funders_on_ein"
  end

  add_foreign_key "awards", "funders"
  add_foreign_key "awards", "funders", column: "recipient_id"
end
