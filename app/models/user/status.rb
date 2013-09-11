# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: User_statuses
#
#  id              :integer          not null, primary key
#  message         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#  User_group_id :integer
#

# -*- encoding : utf-8 -*-
class User::Status < ActiveRecord::Base
  attr_accessible :message

  belongs_to :user, inverse_of: :statuses
  belongs_to :group, :class_name => 'User::Group', inverse_of: :statuses

  has_many :comments, :class_name => 'User::Comment', inverse_of: :statuses
end
