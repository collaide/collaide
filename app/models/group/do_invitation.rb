class Group::DoInvitation
	include ActiveModel::Model
	include ActiveModel::Validations
	
	attr_accessor :email_list, :users_id, :group_id

  validates_with Group::DoInvitationValidator
end