class Member::Parameter < ActiveRecord::Base
  attr_accessible :language, :localization

  belongs_to :user
end
