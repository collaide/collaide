class GroupMailer < ActionMailer::Base
  include Resque::Mailer

  default from: "contact@collaide.com"

  def new_invitation(email_invitation)
    @user = email_invitation.user
    @group = email_invitation.group
    @message = email_invitation.message

    mail to: email_invitation.email, subject: I18n.t('mailer.group.new_invitation.subject', user: @user.to_s, group: @group.to_s)
  end
end
