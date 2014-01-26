# -*- encoding : utf-8 -*-
#

class Group::InvitationProposition < ActiveRecord::Base

  belongs_to :receiver, polymorphic: true
  belongs_to :invitation

end
