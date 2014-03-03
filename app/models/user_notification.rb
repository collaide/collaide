# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: user_notifications
#
#  id          :integer          not null, primary key
#  class_name  :string(255)
#  method_name :string(255)
#  values      :string(255)
#  is_viewed   :boolean          default(FALSE)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class UserNotification < ActiveRecord::Base

  belongs_to :user

  before_create :notify_user

  validates_presence_of :class_name
  validates_presence_of :method_name
  validates_presence_of :values
  validates_presence_of :user

  def print_message
    klass = class_name.constantize.new
    klass.send(method_name.to_sym, *(JSON.parse(self.values)))
  end

  protected
    def notify_user
      u = User.find user_id
      u.has_notifications=true
      u.save
    end
end
