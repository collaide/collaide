class Member::Group::Demand < ActiveRecord::Base
  attr_accessible :message

  belongs_to :user_has_sent, class_name: 'User'

  belongs_to :group, :class_name => 'Member::Group::Group'

  has_and_belongs_to_many :users_are_invited, class_name:  'User'
end
