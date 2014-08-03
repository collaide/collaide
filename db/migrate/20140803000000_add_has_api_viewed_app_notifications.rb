class AddHasApiViewedAppNotifications < ActiveRecord::Migration
  def change
    add_column :app_notifications, :has_api_viewed, :boolean, default: false
  end
end