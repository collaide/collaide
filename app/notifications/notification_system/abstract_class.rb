# -*- encoding : utf-8 -*-
class NotificationSystem::AbstractClass
  require 'yaml'
  def self.perform_later(method, values, options)
    Resque.enqueue(NotificationSystem::Save, self.to_s, method, values, options)
  end
end
