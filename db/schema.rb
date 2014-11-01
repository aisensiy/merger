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

ActiveRecord::Schema.define(version: 20141101082740) do

  create_table "buyers", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "owner"
    t.integer  "industry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "targets", force: true do |t|
    t.string   "name"
    t.string   "owner"
    t.date     "create_date"
    t.integer  "industry_id"
    t.text     "description"
    t.string   "address"
    t.integer  "registered_capital"
    t.float    "big_stockholder_percent",    limit: 24
    t.float    "net_assets",                 limit: 24
    t.float    "liabilities",                limit: 24
    t.float    "total_assets",               limit: 24
    t.float    "t_minus_1_total_assets",     limit: 24
    t.float    "t_minus_2_total_assets",     limit: 24
    t.float    "t_minus_1_operating_income", limit: 24
    t.float    "t_minus_2_operating_income", limit: 24
    t.float    "t_minus_1_net_profit",       limit: 24
    t.float    "net_profit",                 limit: 24
    t.float    "valuation",                  limit: 24
    t.string   "valuation_method"
    t.date     "valuation_date"
    t.float    "transaction_price",          limit: 24
    t.float    "trading_book_value",         limit: 24
    t.float    "static_earnings",            limit: 24
    t.float    "trading_earnings",           limit: 24
    t.float    "three_year_avg_earnings",    limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
