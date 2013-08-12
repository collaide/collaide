# == Schema Information
#
# Table name: member_scolarities
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  member_school_id :integer
#

# -*- encoding : utf-8 -*-
class Member::Scolarity < ActiveRecord::Base

  belongs_to :user
  belongs_to :school, :class_name => 'Member::School'

  has_one :study, :class_name => 'Member::Study'

end
