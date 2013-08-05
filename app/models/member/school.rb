class Member::School < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :scolarities, :class_name => 'Member::Scolarity'
end
