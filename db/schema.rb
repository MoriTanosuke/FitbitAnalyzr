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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140505175810) do

  create_table "activities", :force => true do |t|
    t.decimal  "user_id"
    t.date     "date"
    t.decimal  "calories"
    t.decimal  "steps"
    t.decimal  "distance"
    t.decimal  "floors"
    t.decimal  "elevation"
    t.decimal  "minutesSedentary"
    t.decimal  "minutesLightlyActive"
    t.decimal  "minutesFairlyActive"
    t.decimal  "minutesVeryActive"
    t.decimal  "activeScore"
    t.decimal  "activityCalories"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consumer_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",       :limit => 30
    t.string   "token",      :limit => 1024
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "consumer_tokens", ["token"], :name => "index_consumer_tokens_on_token", :unique => true

  create_table "custom_data", :force => true do |t|
    t.date     "date"
    t.string   "name"
    t.decimal  "value"
    t.decimal  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foods", :force => true do |t|
    t.date     "date"
    t.decimal  "caloriesIn"
    t.decimal  "carbs"
    t.decimal  "fat"
    t.decimal  "fiber"
    t.decimal  "protein"
    t.decimal  "sodium"
    t.decimal  "water"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "user_id"
  end

  create_table "measurements", :force => true do |t|
    t.date     "date"
    t.decimal  "bmi"
    t.decimal  "fat"
    t.decimal  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "user_id"
  end

  create_table "sleeps", :force => true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "awakeningsCount"
    t.integer  "minutesToFallAsleep"
    t.integer  "efficiency"
    t.integer  "minutesAsleep"
    t.integer  "timeInBed"
    t.string   "startTime"
    t.integer  "minutesAwake"
    t.integer  "minutesAfterWakeup"
    t.decimal  "user_id"
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "collection_path"
    t.string   "subscription_id"
    t.datetime "created_at"
    t.decimal  "user_id"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "password_digest"
    t.string   "oauth"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.boolean  "subscribed",      :default => false
    t.string   "role",            :default => "default"
    t.date     "last_login"
  end

end
