class NotificationSystem::DocumentNotifications < NotificationSystem::AbstractClass
  require 'yaml'
  def create(doc_name)
    return " Le document #{doc_name.first} a été créé. Validez-le en suivant ce lien : ..."
  end
end