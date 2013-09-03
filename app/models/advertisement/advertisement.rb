# -*- encoding : utf-8 -*-
class Advertisement::Advertisement < ActiveRecord::Base
  attr_accessible :active, :description, :title, :language, :hits

  #Liaisons
  belongs_to :user

end
