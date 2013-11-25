# -*- encoding : utf-8 -*-
class Document::DocumentObserver < ActiveRecord::Observer

  def after_create(document)
    #On créé une notification pour les administrateurs
    DocumentNotifications.perform_later(
        :create_for_admin, #la méthode de la notif
        [document.title, document.id], # les paramètres de la notification
        user_role: 'super_admin',# on notifie les super-admin
        user_roles: %w[doc_validator admin],# On notifie les admin et les validateurs de documents
    )
    DocumentNotifications.perform_later :create_for_user, [document.title, document.id], user: document.user.id
    UserNotificationsMailer.document_created(document.id).deliver # On envoi un e-mail à celui qui à déposé le document.
  end

  def before_save(document)
    if !document.is_accepted?
      if document.accepted? and Document::Document.find(id).pending?
        document.is_accepted = true
        DocumentNotifications.perform_later(
            :valid_document,
            [document.id, document.user.id],
            user: document.user.id
        )
      end
    end
  end
end
