class AddRelationsToMemberMessageInboxes < ActiveRecord::Migration
  def change
    add_column :member_message_inboxes, :message_id, :integer
    add_column :member_message_inboxes, :user_id, :integer
  end
end
