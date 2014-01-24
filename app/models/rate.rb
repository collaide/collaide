# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: rates
#
#  id            :integer          not null, primary key
#  rater_id      :integer
#  rateable_id   :integer
#  rateable_type :string(255)
#  stars         :float            not null
#  dimension     :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

# -*- encoding : utf-8 -*-
class Rate < ActiveRecord::Base
  belongs_to :rater, :class_name => "User"
  belongs_to :rateable, :polymorphic => true

end
