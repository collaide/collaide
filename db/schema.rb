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

ActiveRecord::Schema.define(:version => 20140122144615) do

  create_table "addresses", :force => true do |t|
    t.string   "country"
    t.string   "street"
    t.integer  "street_number"
    t.integer  "city_code"
    t.string   "country_code"
    t.boolean  "is_actual",     :default => true
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "advertisement_advertisements", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "active"
    t.string   "type"
    t.integer  "user_id"
    t.integer  "book_id_id"
    t.string   "language"
    t.integer  "hits"
    t.decimal  "price",          :precision => 9, :scale => 2
    t.string   "currency"
    t.string   "delivery_modes"
    t.string   "payment_modes"
    t.string   "state"
    t.string   "annotation"
    t.integer  "study_level_id"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "authors"
    t.string   "publisher"
    t.date     "published_date"
    t.text     "description"
    t.string   "isbn_10"
    t.string   "isbn_13"
    t.integer  "page_count"
    t.float    "average_rating"
    t.integer  "ratings_count"
    t.string   "language"
    t.string   "preview_link"
    t.string   "info_link"
    t.string   "image_link"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "comments", :force => true do |t|
    t.string   "title",            :limit => 50, :default => ""
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "conversations", :force => true do |t|
    t.string   "subject",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "document_documents", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "author"
    t.integer  "number_of_pages",  :default => 1
    t.date     "realized_at"
    t.string   "language"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "study_level_id"
    t.integer  "document_type_id"
    t.integer  "user_id"
    t.string   "status",           :default => "pending"
    t.integer  "hits",             :default => 0
    t.boolean  "is_deleted",       :default => false
    t.boolean  "is_accepted",      :default => false
  end

  create_table "document_downloads", :force => true do |t|
    t.integer  "user_id"
    t.integer  "document_documents_id"
    t.integer  "number_of_downloads"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "document_study_level_translations", :force => true do |t|
    t.integer  "document_study_level_id"
    t.string   "locale",                  :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "name"
    t.text     "description"
  end

  add_index "document_study_level_translations", ["document_study_level_id"], :name => "index_08175c174282bb635bbe8dc32fbc2d2926bb130d"
  add_index "document_study_level_translations", ["locale"], :name => "index_document_study_level_translations_on_locale"

  create_table "document_study_levels", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "document_type_translations", :force => true do |t|
    t.integer  "document_type_id"
    t.string   "locale",           :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "name"
    t.text     "description"
  end

  add_index "document_type_translations", ["document_type_id"], :name => "index_document_type_translations_on_document_type_id"
  add_index "document_type_translations", ["locale"], :name => "index_document_type_translations_on_locale"

  create_table "document_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "documents_domains", :force => true do |t|
    t.integer "domain_id"
    t.integer "document_id"
  end

  create_table "domain_translations", :force => true do |t|
    t.integer  "domain_id"
    t.string   "locale",      :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "name"
    t.text     "description"
  end

  add_index "domain_translations", ["domain_id"], :name => "index_domain_translations_on_domain_id"
  add_index "domain_translations", ["locale"], :name => "index_domain_translations_on_locale"

  create_table "domains", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "ancestry"
    t.integer  "position"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "guest_books", :force => true do |t|
    t.string   "name"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "member_group_demands", :force => true do |t|
    t.text     "message2"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "group_id"
  end

  create_table "member_group_groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "is_public",   :default => true
    t.string   "password"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "member_group_members", :force => true do |t|
    t.boolean  "is_admin"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
    t.integer  "member_group_id"
  end

  create_table "messages", :force => true do |t|
    t.text     "body"
    t.string   "subject",         :default => ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",           :default => false
    t.datetime "updated_at",                         :null => false
    t.datetime "created_at",                         :null => false
    t.string   "attachment"
    t.boolean  "global",          :default => false
    t.datetime "expires"
  end

  add_index "messages", ["conversation_id"], :name => "index_notifications_on_conversation_id"

  create_table "rates", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         :null => false
    t.string   "dimension"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "rates", ["rateable_id", "rateable_type"], :name => "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "rating_caches", :force => true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            :null => false
    t.integer  "qty",            :null => false
    t.string   "dimension"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], :name => "index_rating_caches_on_cacheable_id_and_cacheable_type"

  create_table "receipts", :force => true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "message_id",                                     :null => false
    t.boolean  "is_read",                     :default => false
    t.boolean  "trashed",                     :default => false
    t.boolean  "deleted",                     :default => false
    t.string   "mailbox_type",  :limit => 25
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "receipts", ["message_id"], :name => "index_receipts_on_notification_id"

  create_table "repositories", :force => true do |t|
    t.integer "owner_id"
    t.string  "owner_type"
    t.string  "ancestry"
    t.string  "name"
    t.string  "type"
  end

  create_table "shares", :force => true do |t|
    t.integer "owner_id"
    t.string  "owner_type"
    t.integer "repository_id"
    t.boolean "can_create",    :default => false
    t.boolean "can_read",      :default => false
    t.boolean "can_update",    :default => false
    t.boolean "can_delete",    :default => false
    t.boolean "can_share",     :default => false
  end

  create_table "shares_items", :force => true do |t|
    t.integer "share_id"
    t.integer "item_id"
    t.string  "item_type"
    t.boolean "can_add",    :default => false
    t.boolean "can_remove", :default => false
  end

  create_table "statuses", :force => true do |t|
    t.text     "message"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "gender"
    t.integer  "user_users_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "user_friend_demands", :force => true do |t|
    t.text     "message"
    t.integer  "user_has_sent_id"
    t.integer  "user_is_invited_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "user_friend_friends", :force => true do |t|
    t.integer  "user_users_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "user_notifications", :force => true do |t|
    t.string   "class_name"
    t.string   "method_name"
    t.string   "values"
    t.boolean  "is_viewed",   :default => false
    t.integer  "user_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "user_studies", :force => true do |t|
    t.date     "started_at"
    t.date     "ended_at"
    t.string   "orientation"
    t.integer  "user_users_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "user_users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "name"
    t.string   "role"
    t.integer  "points",                 :default => 5
    t.boolean  "has_notifications",      :default => false
    t.string   "provider"
    t.string   "uid"
    t.float    "latitude"
    t.float    "users"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "user_users", ["authentication_token"], :name => "index_user_users_on_authentication_token", :unique => true
  add_index "user_users", ["confirmation_token"], :name => "index_user_users_on_confirmation_token", :unique => true
  add_index "user_users", ["email"], :name => "index_user_users_on_email", :unique => true
  add_index "user_users", ["reset_password_token"], :name => "index_user_users_on_reset_password_token", :unique => true
  add_index "user_users", ["unlock_token"], :name => "index_user_users_on_unlock_token", :unique => true

  create_table "user_users_addresses", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.integer  "addresses_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_foreign_key "messages", "conversations", name: "notifications_on_conversation_id"

  add_foreign_key "receipts", "messages", name: "receipts_on_notification_id"

end
