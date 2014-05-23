class Group::DoInvitation
	include ActiveModel::Model
	include ActiveModel::Validations
	include ActiveModel::Validations::Callbacks

	attr_accessor :email_list, :users_id, :group_id, :message, :users
  after_validation :prepare_for_save

  validates_with Group::DoInvitationValidator

  protected
  def prepare_for_save
    e_list = []
    id_list = []
    users_id.split(',').each do |entry|
      if entry.to_i <= 0
        e_list << entry
      else
        id_list << entry
      end
    end
    self.email_list = e_list
    Rails.logger.debug(self.email_list.inspect + ' akjsdahjsdvhjasvdjhavsdjk')
    self.users = id_list
  end
end