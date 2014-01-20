class ChangeUsersModels < ActiveRecord::Migration
  def change
    rename_column :user_statues, :message2, :content
    rename_column :user_group_demands, :message2, :message
    remove_column :user_statues, :user_id
    remove_column :user_statues, :member_group_id
    # Liaison with users or groups or else
    add_column :user_statues, :owner_id, :integer
    add_column :user_statues, :owner_type, :string

    drop_table :comments
    drop_table :user_comments
    drop_table :c_file_c_files
    drop_table :c_file_folders
    drop_table :c_file_owners
    drop_table :c_file_structures

    rename_table :user_group_demands, :group_demands
    rename_table :user_group_groups, :group_groups
    rename_table :user_group_users, :group_users

    rename_column :group_users, :member_group_id, :group_id
    rename_column :group_users, :user_id, :member_id
    add_column :group_users, :member_type, :string


    drop_table :user_schools
    add_column :group_groups, :type, :string

    rename_column :user_studies, :member_scolarity_id, :group_id
  end
end
