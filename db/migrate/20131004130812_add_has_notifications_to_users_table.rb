# -*- encoding : utf-8 -*-
class AddHasNotificationsToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :has_notifications, :boolean, default:  false
  end
end
