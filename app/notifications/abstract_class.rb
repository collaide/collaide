# -*- encoding : utf-8 -*-
class Notification::AbstractClass
  def register(method, values, owners)
    Resque.enque(Notification::Register, self.class, method, values, owners)
  end
end
