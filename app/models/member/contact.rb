class Member::Contact < ActiveRecord::Base
  attr_accessible :date_of_birth, :first_name, :gender, :last_name

  belongs_to :user
end
