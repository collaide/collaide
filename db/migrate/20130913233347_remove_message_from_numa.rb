class RemoveMessageFromNuma < ActiveRecord::Migration
  def change
    drop_table :user_message_inboxes
    drop_table :user_messages
  end

end
