class Group::DoInvitationValidator < ActiveModel::Validator
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessor :record

  def validate(record)
    @record = record
    @invitations = nil
    if record.users_id.blank?
      record.errors.add :users_id, I18n.t('group.invitations.validation.not_blank')
    end
    if record.group_id.blank?
      record.errors.add :users_id, I18n.t('group.invitations.validation.no_group')
    end

    if (emails = validates_email_list(invitations[:email_list]))
      record.errors.add :users_id, I18n.t('group.invitations.validation.no_valid', count: emails.size, email: emails.join(', '))
    end
    if (users_name = validates_users_id(invitations[:users_id], record.group_id))
      record.errors.add :users_id, I18n.t('group.invitations.validation.already_invited', count: users_name.size, people: users_name.join(', '))
    end
    if (emails_invited = validates_email_invitations(invitations[:email_list], record.group_id))
      record.errors.add :users_id, I18n.t('group.invitations.validation.already_invited_by_email', count: emails_invited.size, email: emails_invited.join(', '))
    end
    if (users_name = check_group_members(invitations[:users_id], record.group_id))
      record.errors.add :users_id, I18n.t('group.invitations.validation.already_member', count: users_name.size, people: users_name.join(', '))
    end
  end

  private

    def invitations
      unless @invitations
        @invitations = {email_list: [], users_id: []}
        record.users_id.split(',').each do |entry|
          if entry.to_i <= 0
            @invitations[:email_list] << entry
          else
            @invitations[:users_id] << entry
          end
        end
      end
      @invitations
    end

    def validates_email_invitations(email_list, group_id)
      email_group_list = []
      email_list.each do |email|
        email_group = Group::EmailInvitation.where(email: email, group_group_id: group_id).to_a
        email_group_list << email_group.first.email if email_group.any?
      end
      Rails.logger.debug(email_group_list.inspect)
      email_group_list.any? ? email_group_list : false
    end

    def check_group_members(ids, group_id)
      return false if ids.empty?
      group = Group::Group.find group_id
      return false if group.nil?
      members = []
      group.members.each do |a_mem|
        if ids.include?(a_mem.id.to_s)
          members << a_mem
        end
      end
      members.empty? ? false  : members.map {|a_user| a_user.to_single_name}
    end

  def validates_users_id(users_id, group_id)
    return false if users_id.empty?
    already_invited = []
    users_id.each do |an_id|
      if(invitation = Group::Invitation.find_by(group_id: group_id, receiver_id: an_id, receiver_type: 'User'))
        already_invited << invitation
      end
    end
    already_invited.empty? ? false : already_invited.map{ |invitation| invitation.receiver.to_single_name.to_s }
  end

  def validates_email_list(email_list)
    unvalid_emails = []
    email_list.each do |an_email|
      unvalid_emails << an_email unless an_email =~ VALID_EMAIL_REGEX
    end
    unvalid_emails.any? ? unvalid_emails : false
  end
end
