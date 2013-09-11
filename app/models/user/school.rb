# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: User_schools
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# -*- encoding : utf-8 -*-
class User::School < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :scolarities, :class_name => 'User::Scolarity'
end
