class CreateMemberGroupMembers < ActiveRecord::Migration
  def change
    create_table :member_group_members do |t|
      t.boolean :is_admin

      t.timestamps
    end
  end
end
