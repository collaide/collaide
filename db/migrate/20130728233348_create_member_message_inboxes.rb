class CreateMemberMessageInboxes < ActiveRecord::Migration
  def change
    create_table :member_message_inboxes do |t|
      t.boolean :is_viewed, default: false
      t.datetime :viewed_at

      t.timestamps
    end
  end
end
