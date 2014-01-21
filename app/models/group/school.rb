# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: group_groups
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

# -*- encoding : utf-8 -*-
class Group::School < Group::Group

  has_many :studies, :class_name => 'User::Study'
end
