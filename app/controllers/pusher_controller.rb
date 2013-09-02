# -*- encoding : utf-8 -*-
class PusherController
  def auth
    if current_user
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
      render :json => response
    else
      render :text => "Not authorized", :status => '403'
    end
  end
end
