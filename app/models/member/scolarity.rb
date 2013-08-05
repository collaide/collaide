class Member::Scolarity < ActiveRecord::Base

  belongs_to :user
  belongs_to :school, :class_name => 'Member::School'

  has_one :study, :class_name => 'Member::Study'

end
