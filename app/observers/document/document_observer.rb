# -*- encoding : utf-8 -*-
class DocumentObserver < ActiveRecord::Observer

  def after_create(document)
     Resque.enque(Document::CreateDocumentNotification, document.id) if current_user.is 'admin'
     Document::DocumentNotification.register :create, document.id, user: current_user
     Document::DocumentNotification.register :create, document.id, role_group: 'admin'
     Document::DocumentNotification.register :create, document.id, group: Member::Group.all.first
     Document::DocumentNotification.register :create, document.id, groups: Member::Group.all
    Resque.enque Notification::Register, Document::DocumentNotification.to_s, :create, document.id,
  end
end
