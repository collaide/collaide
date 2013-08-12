# == Schema Information
#
# Table name: member_schools
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# -*- encoding : utf-8 -*-
class Member::School < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :scolarities, :class_name => 'Member::Scolarity'
end
