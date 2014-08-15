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

ActiveRecord::Schema.define(version: 20140805065230) do

  create_table "available_clouds", id: false, force: true do |t|
    t.integer  "cloud_id"
    t.integer  "system_id"
    t.integer  "priority"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clouds", force: true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "entry_point"
    t.string   "key"
    t.string   "secret"
    t.string   "tenant_id"
    t.text     "template"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.integer  "pattern_id"
    t.integer  "cloud_id"
    t.integer  "operating_system_id"
    t.string   "role"
    t.string   "image"
    t.string   "message"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operating_systems", force: true do |t|
    t.string "name"
  end

  create_table "patterns", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "type"
    t.string   "uri"
    t.string   "revision"
    t.integer  "metadata_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "patterns_clouds", force: true do |t|
    t.integer  "pattern_id"
    t.integer  "cloud_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "systems", force: true do |t|
    t.integer  "pattern_id"
    t.string   "name"
    t.text     "parameters"
    t.string   "monitoring_host"
    t.string   "ip_address"
    t.string   "domain"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "targets", force: true do |t|
    t.integer "cloud_id"
    t.integer "operating_system_id"
    t.string  "source_image"
    t.string  "ssh_username"
  end

end