# -*- encoding : utf-8 -*-
class UserNotificationsMailer < ActionMailer::Base
  include Resque::Mailer
  default from: "contact@collaide.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notifications_mailer.document_created.subject
  #
  def document_created(document_id)
    @document = Document::Document.find document_id
    mail to: @document.user.email
  end
end
