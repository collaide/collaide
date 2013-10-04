class UserNotification < ActiveRecord::Base
   attr_accessible :class_name, :method_name, :values, :user_id

  belongs_to :user

end
