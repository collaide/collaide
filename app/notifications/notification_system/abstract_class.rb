# -*- encoding : utf-8 -*-
class NotificationSystem::AbstractClass < ActionView::Base
  include Rails.application.routes.url_helpers

  def self.perform_later(method, values, options)
    begin
      Resque.enqueue(NotificationSystem::Save, self.to_s, method, values, options)
    rescue Errno::ECONNREFUSED, Redis::CannotConnectError
      Rails.logger.error "Unable to connect to Redis; falling back to synchronous insert notification" if Rails.logger
      NotificationSystem::Save.perform(self.to_s, method, values, options)
    end
  end

  def deleted_message
    raw I18n.t('notifications.deleted')
  end

end
