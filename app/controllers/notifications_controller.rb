# -*- encoding : utf-8 -*-
class NotificationsController < ApplicationController
  load_and_authorize_resource class: UserNotification

  add_breadcrumb I18n.t("notifications.title_page"), :notifications_path

  def index()
    @notifications = current_user.notifications.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json {
        render json: @notifications
      }
    end
  end
end
