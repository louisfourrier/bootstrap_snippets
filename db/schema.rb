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

ActiveRecord::Schema.define(version: 20150429162155) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bootstrapversions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "css_assets_url"
    t.text     "js_assets_url"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "snippet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "favorites", ["snippet_id"], name: "index_favorites_on_snippet_id", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "snippets", force: :cascade do |t|
    t.text     "title"
    t.text     "slug"
    t.text     "image_url"
    t.text     "original_url"
    t.text     "html_content"
    t.text     "html_code"
    t.text     "css_code"
    t.text     "js_code"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "iframe_url_original"
    t.text     "iframe_html_content"
    t.text     "research_name"
    t.string   "token"
    t.integer  "bootstrapversion_id"
    t.integer  "views_count",         default: 0
    t.boolean  "is_scraped",          default: false
    t.boolean  "approved",            default: false
    t.boolean  "refused",             default: false
    t.boolean  "send_for_approval",   default: false
    t.text     "comment_for_refusal"
    t.boolean  "is_analysed",         default: false
    t.integer  "status",              default: 0
  end

  add_index "snippets", ["status"], name: "index_snippets_on_status", using: :btree
  add_index "snippets", ["token"], name: "index_snippets_on_token", using: :btree
  add_index "snippets", ["user_id"], name: "index_snippets_on_user_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.text     "image_url"
    t.string   "first_letter"
    t.string   "research_name"
    t.string   "slug"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "snippets_count"
    t.boolean  "is_bootstrap",   default: false
  end

  add_index "tags", ["slug"], name: "index_tags_on_slug", using: :btree
  add_index "tags", ["snippets_count"], name: "index_tags_on_snippets_count", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pseudo"
    t.boolean  "is_administrator",       default: false
    t.boolean  "is_real",                default: true
    t.string   "slug"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["pseudo"], name: "index_users_on_pseudo", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree

  add_foreign_key "favorites", "snippets"
  add_foreign_key "favorites", "users"
  add_foreign_key "snippets", "users"
  add_foreign_key "taggings", "tags"
end
