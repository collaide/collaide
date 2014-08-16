class CreateApiNotifications < ActiveRecord::Migration
  def change
    create_table :api_notification_api_notifications do |t|
      t.string :owner_type
      t.integer :owner_id
      t.string :type
      t.string :notifier_type
      t.integer :notifier_id
      #t.string :parent_path
      t.string :to_path
      t.string :from_path
      t.timestamps
    end
  end
end
