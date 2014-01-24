class CreateGroupModule < ActiveRecord::Migration
  def change
    create_table :group_groups do |t|
      t.string :name
      t.string :password
      t.string :password_confirmation
      t.string :type
      t.string :can_index_members
      t.string :can_read_member
      t.string :can_delete_member
      t.string :can_write_file
      t.string :can_index_files
      t.string :can_read_file
      t.string :can_delete_file
      t.string :can_index_statuses
      t.string :can_write_status
      t.string :can_delete_status
      t.string :can_create_invitation
      t.string :can_manage_invitations

      t.text :description

      t.belongs_to :group_groups

      t.timestamps
    end

    create_table :group_groups_group_members do |t|
      t.belongs_to :group_groups, index: true
      t.belongs_to :group_members, polymorphic: true
      t.string :role

      t.timestamps
    end

    add_index :group_groups_group_members, :group_members_id, name: :group_member_index

    create_table :group_invitations do |t|
      t.belongs_to :user_users, index: true
      t.belongs_to :group_groups, index: true

      t.timestamps
    end

    create_join_table :group_invitations, :user_users
  end
end
