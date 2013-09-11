# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: User_studies
#
#  id                  :integer          not null, primary key
#  started_at          :date
#  ended_at            :date
#  orientation         :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  User_scolarity_id :integer
#

# -*- encoding : utf-8 -*-
class User::Study < ActiveRecord::Base
  attr_accessible :ended_at, :orientation, :started_at

  belongs_to :scolarity, :class_name => 'User::Scolarity'
end
