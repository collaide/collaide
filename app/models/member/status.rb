class Member::Status < ActiveRecord::Base
  attr_accessible :message

  belongs_to :user, inverse_of: :statuses
  belongs_to :group, :class_name => 'Member::Group', inverse_of: :statuses

  has_many :comments, :class_name => 'Member::Comment', inverse_of: :statuses
end
