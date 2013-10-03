# -*- encoding : utf-8 -*-
class DocumentObserver < ActiveRecord::Observer

  def after_create(document)
     Document::DocumentNotification.register :create, document.id, user: current_user, users: [1, 2, 3]
     Document::DocumentNotification.register :create, document.id, role_group: 'admin'
     Document::DocumentNotification.register :create, document.id, group: Member::Group.all.first
     Document::DocumentNotification.register :create, document.id, groups: Member::Group.all
  end
end
