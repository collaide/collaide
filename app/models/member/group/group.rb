class Member::Group::Group < ActiveRecord::Base
  attr_accessible :description, :is_public, :name, :password

  has_one :repository, :class_name => 'CFile::Structure'

  has_many :statuses, :class_name => 'Member::Status'
  has_many :members, :class_name => 'Member::Group::Member'
  has_many :demands, :class_name => 'Member::Group::Demand'

  validates_presence_of :name

  validates :password, length: {minimum: 5}
end
