# -*- encoding : utf-8 -*-
class NotificationSystem::AbstractClass < ActionView::Base
  include Rails.application.routes.url_helpers

  def self.perform_later(method, values, options)
    #Resque.enqueue(NotificationSystem::Save, self.to_s, method, values, options)
    NotificationSystem::Save.perform(self.to_s, method, values, options)
  end

end
