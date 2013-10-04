# -*- encoding : utf-8 -*-
class UserNotification::AbstractClass
  def self.perform_later(method, values, owners)
    Resque.enqueue(UserNotification::Save, self.to_s, method, values, owners)
  end
end
