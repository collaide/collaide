# -*- encoding : utf-8 -*-
class NotificationSystem::AbstractClass
  require 'yaml'
  def self.perform_later(method, values, owners)
    Resque.enqueue(NotificationSystem::Save, self.to_s, method, values, owners)
  end
end
