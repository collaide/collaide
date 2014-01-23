# -*- encoding : utf-8 -*-
class CreateTableUserNotifications < ActiveRecord::Migration
  def change
    create_table :user_notifications do |t|
      t.string :class_name
      t.string :method_name
      t.string :values
      t.boolean :is_viewed, default: false
      t.belongs_to :user

      t.timestamps
    end
  end
end
