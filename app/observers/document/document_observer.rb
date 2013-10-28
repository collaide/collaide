# -*- encoding : utf-8 -*-
class Document::DocumentObserver < ActiveRecord::Observer

  def after_create(document)
    DocumentNotifications.perform_later :create_for_admin, [document.title, document.id], user_role: 'super_admin', user_roles: %w[doc_validator admin]
    DocumentNotifications.perform_later :create_for_user, [document.title, document.id], user: document.user.id

  end
end
