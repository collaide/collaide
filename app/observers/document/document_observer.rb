# -*- encoding : utf-8 -*-
class Document::DocumentObserver < ActiveRecord::Observer

  # MaClasseDeNotification.perform_later(
  # :la_méthode_contenant_le_texte_de_la_notification,
  # [les_paramètres_de_la_méthode],
  # <pour qui elle doit être créée>)

  def after_create(document)
    #On créé une notification pour les administrateurs
    #DocumentNotifications.perform_later(
    #    :create_for_admin, #la méthode de la notif
    #    [document.id], # les paramètres de la notification
    #    user_role: 'super_admin',# on notifie les super-admin
    #    user_roles: %w[doc_validator admin],# On notifie les admin et les validateurs de documents
    #)
    #DocumentNotifications.perform_later :create_for_user, [document.id], user: document.user.id
    #UserNotificationsMailer.document_created(document.id).deliver # On envoi un e-mail à celui qui à déposé le document.
  end

  def before_save(document)
    #if !document.is_accepted?
    #  if document.accepted? and Document::Document.find(id).pending?
    #    document.is_accepted = true
    #    DocumentNotifications.perform_later(
    #        :valid_document,
    #        [document.id],
    #        user: document.user.id
    #    )
    #  end
    #end
  end
end
