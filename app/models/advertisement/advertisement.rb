class Advertisement::Advertisement < ActiveRecord::Base
  attr_accessible :active, :description, :title, :language

  #Liaisons
  belongs_to :user

end
