# -*- encoding : utf-8 -*-
class CreateGroupModule < ActiveRecord::Migration
  def change
    create_table :group_groups do |t|
      t.string :name
      t.string :password
      #t.string :password_confirmation
      t.string :type
      t.string :can_index_activity
      t.string :can_delete_group
      t.string :can_read_status
      t.string :can_index_members
      t.string :can_read_member
      t.string :can_delete_member
      t.string :can_write_file
      t.string :can_index_files
      t.string :can_read_file
      t.string :can_delete_file
      t.string :can_index_topics
      t.string :can_write_topic
      t.string :can_delete_topic
      t.string :can_create_invitation
      t.string :can_manage_invitations

      t.text :description

      t.belongs_to :main_group
      t.belongs_to :user

      t.timestamps
    end

    create_table :group_group_members do |t|
      t.belongs_to :group, index: true
      t.belongs_to :member, polymorphic: true, index: true
      t.string :role
      t.string :joined_method
      t.belongs_to :invited_or_added_by, polymorphic: true

      t.timestamps
    end
    add_index :group_group_members, [:invited_or_added_by_id, :invited_or_added_by_type], name: :invited_or_added_by_index

    create_table :group_invitations do |t|
      t.text :message
      t.string :status
      t.string :role

      t.belongs_to :sender, polymorphic: true, index: true
      t.belongs_to :group, index: true
      t.belongs_to :receiver, polymorphic: true, index: true


      t.timestamps
    end
    #add_index :group_groups_group_invitations, :sender_id, name: :invitation_sender_index

    #create_join_table :group_invitations, :proposition do |t|
    #  t.belongs_to :receiver, polymorphic: true
    #  t.belongs_to :invitation
    #end

    #create_table :group_invitation_receivers do |t|
    #  t.belongs_to :receiver, polymorphic: true
    #  t.belongs_to :group_invitation, index:true
    #end
    #add_index :group_invitation_receivers, :receiver_id, name: :invitation_receiver_index

    create_table :group_email_invitations do |t|
      t.string :email
      t.text :message
      t.string :secret_token
      t.string :status
      t.belongs_to :group_group
      t.belongs_to :user
    end

  end
end
