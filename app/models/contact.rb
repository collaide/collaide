class Contact < ActiveRecord::Base
  attr_accessible :content, :email, :subject
end
