class Member::Friend::Demand < ActiveRecord::Base
  attr_accessible :message

  belongs_to :user_has_sent, class_name: 'User'
  belongs_to :user_is_invited, class_name: 'User'
end
