class Member::Comment < ActiveRecord::Base
  attr_accessible :message

  belongs_to :status, :class_name => 'Member::Status'
  belongs_to :user


end
