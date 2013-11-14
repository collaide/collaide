class DocumentNotifications < NotificationSystem::AbstractClass

  def create_for_admin(doc_title, doc_id)
    return raw I18n.t(
        'notifications.documents.create_for_admin',
        user: 'user_id',
        title: doc_title,
        link: link_to(I18n.t('notifications.documents.link'), edit_admin_document_document_path(doc_id)))
  end

  def create_for_user(doc_title, doc_id)
    return raw I18n.t(
        'notifications.documents.create_for_user',
        title: link_to(doc_title, document_document_path(doc_id))
    )
  end
end