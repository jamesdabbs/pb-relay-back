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

ActiveRecord::Schema.define(version: 20170202234219) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assumptions", force: :cascade do |t|
    t.bigint "proof_id", null: false
    t.bigint "trait_id", null: false
    t.index ["proof_id"], name: "assumptions_proofs_fk", using: :btree
    t.index ["trait_id"], name: "assumptions_traits_fk", using: :btree
  end

  create_table "emails", force: :cascade do |t|
    t.string "email",   limit: 255, null: false
    t.bigint "user_id"
    t.string "verkey",  limit: 255
    t.index ["email"], name: "unique_email", unique: true, using: :btree
  end

  create_table "proofs", force: :cascade do |t|
    t.bigint   "trait_id",                            null: false
    t.bigint   "theorem_id",                          null: false
    t.datetime "created_at", default: -> { "now()" }
    t.index ["theorem_id"], name: "proofs_theorems_fk", using: :btree
    t.index ["trait_id"], name: "proofs_traits_fk", using: :btree
    t.index ["trait_id"], name: "u_proof_trait", unique: true, using: :btree
  end

  create_table "properties", force: :cascade do |t|
    t.string "name",         limit: 255,                null: false
    t.string "description",                             null: false
    t.bigint "value_set_id",                            null: false
    t.string "aliases",                  default: "[]", null: false
    t.index ["value_set_id"], name: "properties_value_sets_fk", using: :btree
  end

  create_table "query_logs", force: :cascade do |t|
    t.string   "schema_name"
    t.text     "query"
    t.text     "variables"
    t.text     "result"
    t.text     "error"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "remote_users", force: :cascade do |t|
    t.string   "ident",             limit: 255,                          null: false
    t.string   "name",              limit: 255
    t.boolean  "admin",                                                  null: false
    t.datetime "created_at",                    default: -> { "now()" }
    t.datetime "last_logged_in_at",             default: -> { "now()" }
    t.index ["ident"], name: "index_remote_users_on_ident", using: :btree
    t.index ["ident"], name: "unique_user", unique: true, using: :btree
  end

  create_table "revisions", force: :cascade do |t|
    t.bigint   "item_id",                             null: false
    t.string   "item_class",                          null: false
    t.string   "body",                                null: false
    t.bigint   "user_id",                             null: false
    t.datetime "created_at", default: -> { "now()" }
    t.boolean  "deletes",    default: false,          null: false
  end

  create_table "sessions", id: :bigserial, force: :cascade do |t|
    t.bigint   "user_id",                            null: false
    t.datetime "start_at",  default: -> { "now()" }
    t.datetime "expire_at"
    t.string   "token",                              null: false
    t.index ["token"], name: "unique_token", unique: true, using: :btree
  end

  create_table "spaces", force: :cascade do |t|
    t.string "name",              limit: 255, null: false
    t.string "description",                   null: false
    t.string "proof_of_topology"
  end

  create_table "struts", force: :cascade do |t|
    t.bigint "theorem_id", null: false
    t.bigint "trait_id",   null: false
  end

  create_table "supporters", force: :cascade do |t|
    t.bigint "assumed_id", null: false
    t.bigint "implied_id", null: false
  end

  create_table "theorem_properties", force: :cascade do |t|
    t.bigint "theorem_id",  null: false
    t.bigint "property_id", null: false
    t.index ["property_id"], name: "theorem_properties_properties_fk", using: :btree
    t.index ["theorem_id"], name: "theorem_properties_theorems_fk", using: :btree
  end

  create_table "theorems", force: :cascade do |t|
    t.string "description",                             null: false
    t.string "antecedent",   limit: 255,                null: false
    t.string "consequent",   limit: 255,                null: false
    t.string "converse_ids",             default: "[]", null: false
  end

  create_table "traits", force: :cascade do |t|
    t.bigint  "space_id",    null: false
    t.bigint  "property_id", null: false
    t.bigint  "value_id",    null: false
    t.string  "description", null: false
    t.boolean "deduced",     null: false
    t.index ["property_id", "value_id"], name: "index_traits_on_property_id_and_value_id", using: :btree
    t.index ["space_id", "property_id"], name: "trait_s_p", unique: true, using: :btree
    t.index ["space_id"], name: "index_traits_on_space_id", using: :btree
    t.index ["value_id"], name: "traits_values_fk", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255, default: ""
    t.boolean  "admin"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "value_sets", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["name"], name: "u_value_set_name", unique: true, using: :btree
  end

  create_table "values", force: :cascade do |t|
    t.string   "name",         limit: 255, null: false
    t.bigint   "value_set_id",             null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["value_set_id"], name: "index_values_on_value_set_id", using: :btree
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      limit: 255, null: false
    t.bigint   "item_id",                    null: false
    t.string   "event",          limit: 255, null: false
    t.string   "whodunnit",      limit: 255
    t.string   "object"
    t.datetime "created_at",                 null: false
    t.string   "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

  add_foreign_key "assumptions", "proofs", name: "assumptions_proof_id_fkey"
  add_foreign_key "assumptions", "traits", name: "assumptions_trait_id_fkey"
  add_foreign_key "emails", "remote_users", column: "user_id", name: "emails_user_id_fkey"
  add_foreign_key "proofs", "theorems", name: "proofs_theorem_id_fkey"
  add_foreign_key "proofs", "traits", name: "proofs_trait_id_fkey"
  add_foreign_key "properties", "value_sets", name: "properties_value_set_id_fkey"
  add_foreign_key "revisions", "remote_users", column: "user_id", name: "revisions_user_id_fkey"
  add_foreign_key "sessions", "remote_users", column: "user_id", name: "sessions_user_id_fkey"
  add_foreign_key "struts", "theorems", name: "struts_theorem_id_fkey"
  add_foreign_key "struts", "traits", name: "struts_trait_id_fkey"
  add_foreign_key "supporters", "traits", column: "assumed_id", name: "supporters_assumed_id_fkey"
  add_foreign_key "supporters", "traits", column: "implied_id", name: "supporters_implied_id_fkey"
  add_foreign_key "theorem_properties", "properties", name: "theorem_properties_property_id_fkey"
  add_foreign_key "theorem_properties", "theorems", name: "theorem_properties_theorem_id_fkey"
  add_foreign_key "traits", "\"values\"", column: "value_id", name: "traits_value_id_fkey"
  add_foreign_key "traits", "properties", name: "traits_property_id_fkey"
  add_foreign_key "traits", "spaces", name: "traits_space_id_fkey"
  add_foreign_key "values", "value_sets", name: "values_value_set_id_fkey"
end
