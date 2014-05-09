# -*- encoding : utf-8 -*-
class DocumentNotifications < NotificationSystem::AbstractClass

  def create_for_admin(doc_id)
    document = Document::Document.find_by id: doc_id
    if (document)
      raw I18n.t(
              'notifications.documents.create_for_admin',
              user: link_to(h(document.user.to_s), user_path(document.user)),
              title: link_to(h(document.title), document_document_path(document)),
              link: link_to(I18n.t('notifications.link'), RailsAdmin::Engine.routes.url_helpers.edit_path('Document::Document', doc_id)))
    else
      raw I18n.t(
              'notifications.documents.create_for_admin_deleted',
              user: link_to(h(document.user.to_s), user_path(document.user)))
    end
  end

  def create_for_user(doc_id)
    document = Document::Document.find_by id: doc_id
    unless (document)
      return
    end
    raw I18n.t(
        'notifications.documents.create_for_user',
        title: link_to(h(document.title), document_document_path(document))
    )
  end

  def valid_document(doc_id)
    document = Document::Document.find_by id: doc_id
    user = document.user
    unless (document)
      return
    end
    raw t(
            "notifications.documents.valid_document",
            title: link_to(h(document.title), document_document_path(document)),
            user: link_to(h(user), user_path(user))
        )
  end
end
