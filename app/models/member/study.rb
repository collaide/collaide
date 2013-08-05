class Member::Study < ActiveRecord::Base
  attr_accessible :ended_at, :orientation, :started_at

  belongs_to :scolarity, :class_name => 'Member::Scolarity'
end
