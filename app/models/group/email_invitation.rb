class Group::EmailInvitation < ActiveRecord::Base
  belongs_to :group_group, :class_name => 'Group::Group'
  belongs_to :user
end
