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

ActiveRecord::Schema.define(:version => 20130830185456423) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "advertisement_advertisements", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "active"
    t.string   "type"
    t.decimal  "price",          :precision => 9, :scale => 2
    t.string   "currency"
    t.string   "state"
    t.string   "annotation"
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.integer  "user_id"
    t.string   "language"
    t.integer  "book_id"
    t.integer  "hits",                                         :default => 0
    t.string   "delivery_modes"
    t.string   "payment_modes"
    t.integer  "study_level_id"
  end

  create_table "blog_comments", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "email",      :null => false
    t.string   "website"
    t.text     "body",       :null => false
    t.integer  "post_id",    :null => false
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "blog_comments", ["post_id"], :name => "index_blog_comments_on_post_id"

  create_table "blog_posts", :force => true do |t|
    t.string   "title",                         :null => false
    t.text     "body",                          :null => false
    t.integer  "blogger_id"
    t.string   "blogger_type"
    t.integer  "comments_count", :default => 0, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "blog_posts", ["blogger_type", "blogger_id"], :name => "index_blog_posts_on_blogger_type_and_blogger_id"

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

  create_table "c_file_c_files", :force => true do |t|
    t.integer  "rights"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "document_id"
    t.integer  "bit_mask"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "c_file_folders", :force => true do |t|
    t.integer  "c_file_id"
    t.integer  "structure_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "c_file_owners", :force => true do |t|
    t.string   "name"
    t.integer  "rights"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "c_file_structures", :force => true do |t|
    t.string   "name"
    t.integer  "size"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
    t.integer  "member_group_id"
    t.integer  "c_file_c_file_id"
    t.string   "ancestry"
    t.integer  "position"
  end

  add_index "c_file_structures", ["ancestry"], :name => "index_c_file_structures_on_ancestry"
  add_index "c_file_structures", ["member_group_id"], :name => "index_c_file_structures_on_member_group_id"
  add_index "c_file_structures", ["user_id"], :name => "index_c_file_structures_on_user_id"

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

  create_table "delivery_modes_sales", :force => true do |t|
    t.integer "delivery_mode_id"
    t.integer "sale_id"
  end

  create_table "demands_users", :force => true do |t|
    t.integer "demand_id"
    t.integer "user_id"
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
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
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
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
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
    t.string   "locale"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "domain_translations", ["domain_id"], :name => "index_domain_translations_on_domain_id"
  add_index "domain_translations", ["locale"], :name => "index_domain_translations_on_locale"

  create_table "domains", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "ancestry"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "position"
  end

  add_index "domains", ["ancestry"], :name => "index_domains_on_ancestry"

  create_table "domains_sale_books", :force => true do |t|
    t.integer "domain_id"
    t.integer "sale_book_id"
  end

  create_table "group_demands_users", :force => true do |t|
    t.integer "demand_id"
    t.integer "user_id"
  end

  create_table "guest_books", :force => true do |t|
    t.string   "name"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              :default => ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                :default => false
    t.datetime "updated_at",                              :null => false
    t.datetime "created_at",                              :null => false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
    t.boolean  "global",               :default => false
    t.datetime "expires"
  end

  add_index "notifications", ["conversation_id"], :name => "index_notifications_on_conversation_id"

  create_table "payment_modes_sales", :force => true do |t|
    t.integer "payment_mode_id"
    t.integer "sale_id"
  end

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
    t.integer  "notification_id",                                  :null => false
    t.boolean  "is_read",                       :default => false
    t.boolean  "trashed",                       :default => false
    t.boolean  "deleted",                       :default => false
    t.string   "mailbox_type",    :limit => 25
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "receipts", ["notification_id"], :name => "index_receipts_on_notification_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "user_addresses", :force => true do |t|
    t.string   "country"
    t.string   "street"
    t.integer  "street_number"
    t.integer  "city_code"
    t.string   "country_code"
    t.boolean  "is_actual",     :default => true
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "user_addresses_users", :force => true do |t|
    t.integer "address_id"
    t.integer "user_id"
  end

  create_table "user_comments", :force => true do |t|
    t.text     "message"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "member_status_id"
    t.integer  "user_id"
  end

  add_index "user_comments", ["user_id"], :name => "index_member_comments_on_user_id"

  create_table "user_contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.string   "gender"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "user_id"
  end

  add_index "user_contacts", ["user_id"], :name => "index_member_contacts_on_user_id"

  create_table "user_friend_demands", :force => true do |t|
    t.text     "message"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "user_has_sent_id"
    t.integer  "user_is_invited_id"
  end

  create_table "user_friend_friends", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "user_group_demands", :force => true do |t|
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "group_id"
  end

  create_table "user_group_groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "is_public",   :default => true
    t.string   "password"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "user_group_users", :force => true do |t|
    t.boolean  "is_admin"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
    t.integer  "member_group_id"
  end

  create_table "user_notifications", :force => true do |t|
    t.string   "class_name"
    t.string   "method_name"
    t.string   "values"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_parameters", :force => true do |t|
    t.string   "language"
    t.string   "localization"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "user_id"
  end

  add_index "user_parameters", ["user_id"], :name => "index_member_parameters_on_user_id"

  create_table "user_schools", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_scolarities", :force => true do |t|
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "user_id"
    t.integer  "member_school_id"
  end

  create_table "user_statues", :force => true do |t|
    t.text     "message"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
    t.integer  "member_group_id"
  end

  create_table "user_studies", :force => true do |t|
    t.date     "started_at"
    t.date     "ended_at"
    t.string   "orientation"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "member_scolarity_id"
  end

  add_index "user_studies", ["member_scolarity_id"], :name => "index_member_studies_on_member_scolarity_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "name"
    t.integer  "role_mask"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "points",                 :default => 5
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  add_foreign_key "notifications", "conversations", name: "notifications_on_conversation_id"

  add_foreign_key "receipts", "notifications", name: "receipts_on_notification_id"

end
