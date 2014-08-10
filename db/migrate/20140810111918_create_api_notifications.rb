class CreateApiNotifications < ActiveRecord::Migration
  def change
    create_table :api_notifications do |t|
      t.string :owner_type
      t.integer :owner_id
      t.string :notification_type
      t.string :notifier_type
      t.integer :notifier_id
      t.timestamps
    end
  end
end
