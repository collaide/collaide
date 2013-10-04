class UserNotification::DocumentNotifications < UserNotification::AbstractClass

  def create(doc_id)
    document = Document::Document.find doc_id
    data = {message: "Le document #{document.title} a été créé par le membre #{document.user.name} à #{I18n.l(document.created_at, format: :long)}"}
    data
  end
end