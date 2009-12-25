# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 6) do

  create_table "binds", :force => true do |t|
    t.integer "user_id",                         :null => false
    t.integer "project_id",                      :null => false
    t.string  "kind",       :default => "watch", :null => false
  end

  add_index "binds", ["project_id"], :name => "index_binds_on_project_id"
  add_index "binds", ["user_id", "project_id"], :name => "index_binds_on_user_id_and_project_id"
  add_index "binds", ["user_id"], :name => "index_binds_on_user_id"

  create_table "groups", :force => true do |t|
    t.string   "name",                :null => false
    t.text     "info"
    t.datetime "sync_at"
    t.string   "permalink"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["name"], :name => "index_groups_on_name"
  add_index "groups", ["sync_at"], :name => "index_groups_on_sync_at"

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name",                          :null => false
    t.string   "url"
    t.string   "todo"
    t.string   "wiki"
    t.string   "forum"
    t.string   "mailist"
    t.string   "irc"
    t.integer  "devs",       :default => 0,     :null => false
    t.integer  "karma",      :default => 0,     :null => false
    t.integer  "skill",      :default => 0,     :null => false
    t.integer  "todos",      :default => 0,     :null => false
    t.integer  "forks",      :default => 0,     :null => false
    t.integer  "watchers",   :default => 0,     :null => false
    t.text     "info"
    t.boolean  "fork",       :default => false, :null => false
    t.boolean  "tests",      :default => false, :null => false
    t.datetime "synced_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["devs"], :name => "index_projects_on_devs"
  add_index "projects", ["forks"], :name => "index_projects_on_forks"
  add_index "projects", ["karma"], :name => "index_projects_on_karma"
  add_index "projects", ["name"], :name => "index_projects_on_name"
  add_index "projects", ["skill"], :name => "index_projects_on_skill"
  add_index "projects", ["synced_at"], :name => "index_projects_on_synced_at"
  add_index "projects", ["url"], :name => "index_projects_on_url"
  add_index "projects", ["watchers"], :name => "index_projects_on_watchers"

  create_table "pubs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "head",       :null => false
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pubs", ["head"], :name => "index_pubs_on_head"
  add_index "pubs", ["project_id"], :name => "index_pubs_on_project_id"
  add_index "pubs", ["user_id"], :name => "index_pubs_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer "tag_id",        :null => false
    t.integer "taggable_id"
    t.string  "taggable_type"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string  "name",                          :null => false
    t.integer "taggings_count", :default => 0, :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"
  add_index "tags", ["taggings_count"], :name => "index_tags_on_taggings_count"

  create_table "users", :force => true do |t|
    t.string   "login",               :limit => 80,                         :null => false
    t.string   "kind",                :limit => 10,                         :null => false
    t.string   "email",               :limit => 100
    t.string   "name",                :limit => 100, :default => ""
    t.string   "state",                              :default => "passive", :null => false
    t.string   "motto"
    t.string   "url"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "time_zone",           :limit => 50,                         :null => false
    t.string   "locale",              :limit => 50,                         :null => false
    t.datetime "last_login_at"
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.integer  "login_count"
    t.integer  "skill"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "on",                                 :default => false,     :null => false
    t.string   "openid_identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["kind"], :name => "index_users_on_kind"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["on"], :name => "index_users_on_on"
  add_index "users", ["openid_identifier"], :name => "index_users_on_openid_identifier"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
  add_index "users", ["single_access_token"], :name => "index_users_on_single_access_token"
  add_index "users", ["skill"], :name => "index_users_on_skill"

end
