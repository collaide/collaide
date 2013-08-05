class Member::Group::Member < ActiveRecord::Base
  attr_accessible :is_admin

  belongs_to :user
  belongs_to :member_group, :class_name => 'Member::Group::Group'
end
