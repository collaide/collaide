class Advertisement::Advertisement < ActiveRecord::Base
  attr_accessible :active, :description, :title

  #Liaisons
  belongs_to :user
end
