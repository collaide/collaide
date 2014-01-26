# -*- encoding : utf-8 -*-
#

class Group::InvitationReceiver < ActiveRecord::Base

  belongs_to :receiver, polymorphic: true
  belongs_to :invitation

end
