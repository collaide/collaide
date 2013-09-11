# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: User_comments
#
#  id               :integer          not null, primary key
#  message          :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  User_status_id :integer
#  user_id          :integer
#

# -*- encoding : utf-8 -*-
class User::Comment < ActiveRecord::Base
  attr_accessible :message

  belongs_to :status, :class_name => 'User::Status'
  belongs_to :user


end
