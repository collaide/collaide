class UserNotificationsMailer < ActionMailer::Base
  default from: "contact@collaide.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notifications_mailer.document_created.subject
  #
  def document_created(document)
    @document = document
    mail to: @document.user.email
  end
end
