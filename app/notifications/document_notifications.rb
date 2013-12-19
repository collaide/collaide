class DocumentNotifications < NotificationSystem::AbstractClass

  def create_for_admin(doc_id)
    document = Document::Document.find doc_id
   raw I18n.t(
        'notifications.documents.create_for_admin',
        user: h(document.user.to_s),
        title: h(document.title),
        link: link_to(I18n.t('notifications.documents.link'), edit_admin_document_document_path(document)))
  end

  def create_for_user(doc_id)
    document = Document::Document.find doc_id
    raw I18n.t(
        'notifications.documents.create_for_user',
        title: link_to(h(document.title), document_document_path(document))
    )
  end

  def valid_document(doc_id)
    document = Document::Document.find doc_id
    user = document.user
    raw t(
            "notifications.documents.valid_document",
            title: link_to(h(document.title), document_document_path(document)),
            user: link_to(h(user), user_path(user))
        )
  end
end