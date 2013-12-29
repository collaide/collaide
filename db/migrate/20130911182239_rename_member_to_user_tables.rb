# -*- encoding : utf-8 -*-
class RenameMemberToUserTables < ActiveRecord::Migration
  def change
    rename_table :member_addresses, :user_addresses
    rename_table :member_addresses_users, :user_addresses_users
    rename_table :member_comments, :user_comments
    rename_table :member_contacts, :user_contacts
    rename_table :member_friend_demands, :user_friend_demands
    rename_table :member_friend_friends, :user_friend_friends
    rename_table :member_group_demands, :user_group_demands
    rename_table :member_group_groups, :user_group_groups
    rename_table :member_group_members, :user_group_users
    rename_table :member_message_inboxes, :user_message_inboxes
    rename_table :member_messages, :user_messages
    rename_table :member_parameters, :user_parameters
    rename_table :member_schools, :user_schools
    rename_table :member_scolarities, :user_scolarities
    rename_table :member_statuses, :user_statues
    rename_table :member_studies, :user_studies
  end
end
