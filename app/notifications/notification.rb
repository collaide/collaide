# -*- encoding : utf-8 -*-
class Notification
  def send (message, title='')
    Pusher['private-'+params[:message][:recipient_id]].trigger(title, {:msg => message})
  end
end
