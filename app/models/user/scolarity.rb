# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: User_scolarities
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  User_school_id :integer
#

# -*- encoding : utf-8 -*-
class User::Scolarity < ActiveRecord::Base

  belongs_to :user
  belongs_to :school, :class_name => 'Group::School'

  has_one :study, :class_name => 'User::Study'

end
