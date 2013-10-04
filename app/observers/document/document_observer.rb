# -*- encoding : utf-8 -*-
class DocumentObserver < ActiveRecord::Observer

  def after_create(document)
     UserNotification::DocumentNotifications.perform_later :create, document.id, user: current_user, users: [1, 2, 3]
     Document::DocumentNotification.perform_later :create, document.id, role_group: 'admin'
     Document::DocumentNotification.perform_later :create, document.id, group: Member::Group.all.first
     Document::DocumentNotification.perform_later :create, document.id, groups: Member::Group.all
  end
end
