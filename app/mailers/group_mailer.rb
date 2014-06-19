class GroupMailer < ApplicationMailer

  def new_invitation(email_invitation)
    @user = User.find email_invitation['user_id'].to_i
    @group = Group::Group.find email_invitation['group_group_id'].to_i
    @message = email_invitation['message']
    @secret_token = email_invitation['secret_token']
    @email_id = email_invitation['id']

    mail to: email_invitation['email'], subject: I18n.t('mailer.group.new_invitation.subject', user: @user.to_s, group: @group.to_s)
  end
end