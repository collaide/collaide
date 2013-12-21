# -*- encoding : utf-8 -*-
# This migration comes from mailboxer_engine (originally 20131003214212)
class ChangeRelations < ActiveRecord::Migration

  def change
    rename_column :receipts, :notification_id, :message_id
  end
end
