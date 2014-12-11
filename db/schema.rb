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

ActiveRecord::Schema.define(version: 20141211004045) do

  create_table "bargains", force: true do |t|
    t.string   "payment_type"
    t.string   "consultant"
    t.integer  "year"
    t.date     "sale_at"
    t.string   "buyer_name"
    t.string   "buyer_stock_code"
    t.string   "buyer_industry"
    t.string   "bargain_type"
    t.float    "support_fund",          limit: 24
    t.string   "support_fund_use"
    t.float    "bargain_value",         limit: 24
    t.date     "value_at"
    t.float    "target_estimate_value", limit: 24
    t.string   "target_name"
    t.string   "target_industry"
    t.string   "target_business"
    t.float    "target_net_asset",      limit: 24
    t.float    "target_income",         limit: 24
    t.float    "net_profit",            limit: 24
    t.float    "net_profit_t",          limit: 24
    t.float    "net_profit_t_1",        limit: 24
    t.float    "net_profit_t_2",        limit: 24
    t.float    "net_profit_t_3",        limit: 24
    t.float    "capital_based_value",   limit: 24
    t.float    "profit_based_value",    limit: 24
    t.float    "market_based_value",    limit: 24
    t.string   "pricing_method"
    t.float    "growth_ratio",          limit: 24
    t.float    "static_pe",             limit: 24
    t.float    "dynamic_pe",            limit: 24
    t.float    "ps",                    limit: 24
    t.float    "pb",                    limit: 24
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buyer_v2s", force: true do |t|
    t.string   "stock_code"
    t.string   "company_name"
    t.string   "actual_controller"
    t.float    "ssh_prop",          limit: 24
    t.string   "owner_type"
    t.integer  "bargain_freq"
    t.date     "ipo_at"
    t.date     "start_at"
    t.string   "industry"
    t.text     "main_product"
    t.string   "main_product_type"
    t.string   "region"
    t.float    "cash_reserve_2",    limit: 24
    t.float    "cash_reserve_3",    limit: 24
    t.float    "cash_reserve_1",    limit: 24
    t.float    "growth_ratio_1",    limit: 24
    t.float    "growth_ratio_2",    limit: 24
    t.float    "growth_ratio_3",    limit: 24
    t.float    "net_profit",        limit: 24
    t.float    "roe",               limit: 24
    t.string   "concept_sector"
    t.integer  "row_index"
    t.float    "pe",                limit: 24
    t.float    "market_value",      limit: 24
    t.float    "pb",                limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buyers", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "owner"
    t.integer  "industry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "market_value",               limit: 24
    t.float    "t_minus_1_market_value",     limit: 24
    t.float    "t_minus_2_market_value",     limit: 24
    t.float    "net_profit",                 limit: 24
    t.float    "t_minus_1_net_profit",       limit: 24
    t.float    "t_minus_2_net_profit",       limit: 24
    t.float    "operating_income",           limit: 24
    t.float    "t_minus_1_operating_income", limit: 24
    t.float    "t_minus_2_operating_income", limit: 24
  end

  create_table "deals", force: true do |t|
    t.integer  "buyer_id"
    t.integer  "target_id"
    t.date     "draft_announce_date"
    t.string   "report_name"
    t.string   "consultant"
    t.string   "pay_method"
    t.float    "financing",                  limit: 24
    t.string   "finacing_target"
    t.string   "finacing_use"
    t.float    "net_assets",                 limit: 24
    t.float    "liabilities",                limit: 24
    t.float    "total_assets",               limit: 24
    t.float    "t_minus_1_total_assets",     limit: 24
    t.float    "t_minus_2_total_assets",     limit: 24
    t.float    "t_minus_1_net_assets",       limit: 24
    t.float    "t_minus_2_net_assets",       limit: 24
    t.float    "t_minus_1_operating_income", limit: 24
    t.float    "t_minus_2_operating_income", limit: 24
    t.float    "t_minus_1_net_profit",       limit: 24
    t.float    "net_profit",                 limit: 24
    t.float    "t_plus_1_net_profit",        limit: 24
    t.float    "t_plus_2_net_profit",        limit: 24
    t.float    "t_plus_3_net_profit",        limit: 24
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
    t.float    "t_minus_1_net_assets",       limit: 24
    t.float    "t_minus_2_net_assets",       limit: 24
    t.float    "t_minus_1_operating_income", limit: 24
    t.float    "t_minus_2_operating_income", limit: 24
    t.float    "t_minus_1_net_profit",       limit: 24
    t.float    "net_profit",                 limit: 24
    t.boolean  "is_sold"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
