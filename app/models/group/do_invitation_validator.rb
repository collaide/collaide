class Group::DoInvitationValidator < ActiveModel::Validator
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  def validate(record)
    if record.email_list.blank?
      record.errors.add :email_list, I18n.t('group.invitations.validation.not_blank')
    end
    if validates_email_list(record)
      record.errors.add :email_list, I18n.t('group.invitations.validation.no_valid')
    end
    if (users_name = validates_users_id(record))
      record.errors.add :email_list, I18n.t('group.invitations.validation.already_invited', people: users_name)
    end
    if (users_name = check_group_members(record))
      record.errors.add :email_list, I18n.t('group.invitations.validation.already_member', people: users_name)
    end
  end

  private

    def check_group_members(record)
      return false if record.users_id.nil? or record.users_id.empty?
      ids = record.users_id
      return false if ids.empty?
      group = Group::Group.find record.group_id
      return false if group.nil?
      members = []
      group.members.each do |a_mem|
        if ids.include?(a_mem.id.to_s)
          members << a_mem
        end
      end
      members.empty? ? false  : members.map {|a_user| a_user.to_s}.join(', ')
    end

  def validates_users_id(record)
    return false if record.users_id.nil?
    ids = record.users_id.split
    already_invited = []
    ids.each do |an_id|
      if(invitation = Group::Invitation.find_by(group_id: record.group_id, receiver_id: an_id, receiver_type: 'User'))
        already_invited << invitation
      end
    end
    already_invited.empty? ? false : already_invited.map{|invitation| invitation.receiver.to_single_name.to_s}.join(', ')
  end

  def validates_email_list(record)
    return true if record.users_id.nil?
    users_id = []
    addresses = []
    record.users_id.split(',').each do |id|
      if id.to_i == 0
        addresses << id
      else
        users_id << id if id.to_i != 0
      end
    end
    users_id.each do |an_id|
      return false if !an_id.blank?
    end
    return true if addresses.empty? and users_id.empty?
    return false if !addresses.empty
    no_valid_addresses = true
    addresses.each do |an_email|
      if an_email =~ VALID_EMAIL_REGEX
        no_valid_addresses = false
      end
    end
    no_valid_addresses
  end
end
