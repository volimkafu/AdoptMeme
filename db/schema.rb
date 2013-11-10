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

ActiveRecord::Schema.define(:version => 20131110103803) do

  create_table "captions", :force => true do |t|
    t.string   "top_text"
    t.string   "bottom_text"
    t.integer  "captioner_id"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "image_id"
    t.string   "top_text_align",    :default => "center"
    t.string   "bottom_text_align", :default => "center"
    t.string   "amazon_aws_url"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0, :null => false
    t.integer  "attempts",   :default => 0, :null => false
    t.text     "handler",                   :null => false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "images", :force => true do |t|
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "petfinder_url"
    t.string   "amazon_aws_url"
    t.integer  "pet_id"
  end

  add_index "images", ["pet_id"], :name => "index_images_on_pet_id"

  create_table "pets", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "name"
    t.string   "sex"
    t.integer  "petfinder_id"
    t.integer  "shelter_id"
    t.text     "description"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "zipcode",         :default => "00000"
    t.string   "password_digest"
    t.string   "session_token"
  end

end
