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

ActiveRecord::Schema.define(version: 20160624201038) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
  end

  add_index "audits", ["associated_id", "associated_type"], name: "associated_index", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_recipes", id: false, force: :cascade do |t|
    t.integer  "category_id"
    t.integer  "recipe_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "categories_recipes", ["category_id", "recipe_id"], name: "index_categories_recipes_on_category_id_and_recipe_id", using: :btree
  add_index "categories_recipes", ["category_id"], name: "index_categories_recipes_on_category_id", using: :btree
  add_index "categories_recipes", ["recipe_id"], name: "index_categories_recipes_on_recipe_id", using: :btree

  create_table "garnishes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "garnishes_recipes", force: :cascade do |t|
    t.integer  "garnish_id"
    t.integer  "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "garnishes_recipes", ["garnish_id"], name: "index_garnishes_recipes_on_garnish_id", using: :btree
  add_index "garnishes_recipes", ["recipe_id"], name: "index_garnishes_recipes_on_recipe_id", using: :btree

  create_table "glasses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "image_url_file_name"
    t.string   "image_url_content_type"
    t.integer  "image_url_file_size"
    t.datetime "image_url_updated_at"
  end

  create_table "ingredients", force: :cascade do |t|
    t.integer  "scratchedoffshoppingcart"
    t.integer  "shoppingcart"
    t.string   "name"
    t.string   "optionalassetname"
    t.string   "secondaryname"
    t.string   "type"
    t.integer  "cabinet"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "image_url_file_name"
    t.string   "image_url_content_type"
    t.integer  "image_url_file_size"
    t.datetime "image_url_updated_at"
    t.string   "image_highlight_url_file_name"
    t.string   "image_highlight_url_content_type"
    t.integer  "image_highlight_url_file_size"
    t.datetime "image_highlight_url_updated_at"
  end

  create_table "ingredients_recipes", force: :cascade do |t|
    t.integer  "ingredient_id"
    t.integer  "recipe_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "ingredients_recipes", ["ingredient_id"], name: "index_ingredients_recipes_on_ingredient_id", using: :btree
  add_index "ingredients_recipes", ["recipe_id"], name: "index_ingredients_recipes_on_recipe_id", using: :btree

  create_table "lists", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url_file_name"
    t.string   "image_url_content_type"
    t.integer  "image_url_file_size"
    t.datetime "image_url_updated_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "lists_recipes", id: false, force: :cascade do |t|
    t.integer  "list_id"
    t.integer  "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lists_recipes", ["list_id"], name: "index_lists_recipes_on_list_id", using: :btree
  add_index "lists_recipes", ["recipe_id"], name: "index_lists_recipes_on_recipe_id", using: :btree

  create_table "recipe_steps", force: :cascade do |t|
    t.integer  "stepindex"
    t.integer  "recipe_id"
    t.text     "stepamount"
    t.text     "steptitle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.integer  "alcoholic"
    t.integer  "drinkid"
    t.integer  "edited"
    t.integer  "favorite"
    t.integer  "issuggested"
    t.integer  "glass_id"
    t.integer  "recipe_steps_id"
    t.text     "information"
    t.text     "instructions"
    t.string   "name"
    t.string   "notes"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "similar_recipes", force: :cascade do |t|
    t.integer  "recipe_id"
    t.integer  "reflexive_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "similar_recipes", ["recipe_id"], name: "index_similar_recipes_on_recipe_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "name"
    t.integer  "role"
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "nickname"
    t.string   "image"
    t.json     "tokens"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

  create_table "version_histories", force: :cascade do |t|
    t.integer  "version"
    t.string   "table_name"
    t.string   "action"
    t.string   "primary_keys"
    t.text     "change_fields"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_foreign_key "categories_recipes", "categories"
  add_foreign_key "categories_recipes", "recipes"
  add_foreign_key "garnishes_recipes", "garnishes"
  add_foreign_key "garnishes_recipes", "recipes"
  add_foreign_key "ingredients_recipes", "ingredients"
  add_foreign_key "ingredients_recipes", "recipes"
  add_foreign_key "lists_recipes", "lists"
  add_foreign_key "lists_recipes", "recipes"
  add_foreign_key "recipe_steps", "recipes"
  add_foreign_key "recipes", "glasses"
  add_foreign_key "similar_recipes", "recipes"
end
