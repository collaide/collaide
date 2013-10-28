class DocumentNotifications < NotificationSystem::AbstractClass
  require 'yaml'
  def create_for_admin(doc_name)
    return I18n.t(
        'notifications.documents.create_for_admin',
        user: doc_name[2],
        title: doc_name[0],
        link: helper.link_to(I18n.t('notifications.documents.link'), app.edit_admin_document_document_path(doc_name[1])))
  end

  def create_for_user(document)
    return I18n.t(
        'notifications.documents.create_for_user',
        title: helper.link_to(document[0], app.document_document_path(document[1]))
    )
  end
end