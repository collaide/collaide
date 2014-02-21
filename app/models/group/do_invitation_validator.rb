class Group::DoInvitationValidator < ActiveModel::Validator
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  def validate(record)
    if record.email_list.blank?
      record.errors.add :email_list, 'Not Blank'
    end
    if validates_email_list(record) and record.users_id.blank?
      record.errors.add :email_list, 'Pas valide'
    end
    if (users_name = validates_users_id(record))
      record.errors.add :email_list, users_name
    end
    if
  end

  private

    def check_group_members(record)
      return false if record.users_id.nil? or record.users_id.empty?
      group = Group::Group.find record.group_id
      return false if group.nil?
      members = []
      group.members.each do |a_mem|
        members << a_mem unless record.users_id.index(a_mem.id).nil?
        end
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
    return true if record.email_list.nil?
    addresses = record.email_list.split(', ')
    return false if addresses.empty?
    no_valid_addresses = true
    addresses.each do |an_email|
      if an_email =~ VALID_EMAIL_REGEX
        no_valid_addresses = false
      end
    end
    no_valid_addresses
  end
end