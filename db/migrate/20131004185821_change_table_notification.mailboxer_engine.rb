# This migration comes from mailboxer_engine (originally 20131003144212)
class ChangeTableNotification < ActiveRecord::Migration

  def change
    rename_table :notifications, :messages
    remove_column :messages, :type
    remove_column :messages, :notified_object_id
    remove_column :messages, :notified_object_type
    remove_column :messages, :notification_code


  end
end
