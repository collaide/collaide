# -*- encoding : utf-8 -*-
class DocumentObserver < ActiveRecord::Observer

  def after_create(document)
     Resque.enque(Document::CreateDocumentNotification, document.id) if current_user.is 'admin'
  end
end
