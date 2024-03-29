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

ActiveRecord::Schema.define(version: 2019_06_01_190350) do

  create_table "episodes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "number", null: false
    t.string "title", null: false
    t.text "plot", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "season_id"
    t.index ["number", "season_id"], name: "index_episodes_on_number_and_season_id", unique: true
    t.index ["season_id"], name: "index_episodes_on_season_id"
  end

  create_table "movies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "plot", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchase_opts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "product_id", null: false
    t.string "product_type", null: false
    t.integer "quality", null: false
    t.float "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "purchases", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "purchase_opt_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purchase_opt_id"], name: "index_purchases_on_purchase_opt_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "seasons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", null: false
    t.text "plot", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "episodes", "seasons"
end
