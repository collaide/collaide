class DocumentNotifications < NotificationSystem::AbstractClass

  def create_for_admin(doc_title, doc_id)
   raw I18n.t(
        'notifications.documents.create_for_admin',
        user: 'user_id',
        title: h(doc_title),
        link: link_to(I18n.t('notifications.documents.link'), edit_admin_document_document_path(doc_id)))
  end

  def create_for_user(doc_title, doc_id)
    raw I18n.t(
        'notifications.documents.create_for_user',
        title: link_to(h(doc_title), document_document_path(doc_id))
    )
  end

  def valid_document(doc_id, user_id)
    document = Document::Document.find doc_id
    user = User.find user_id
    raw t(
            "notifications.documents.valid_document",
            title: link_to(h(document.title), document_document_path(document)),
            user: link_to(h(user), user_path(user))
        )
  end
end