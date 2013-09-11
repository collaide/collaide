# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: User_parameters
#
#  id           :integer          not null, primary key
#  language     :string(255)
#  localization :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#

# -*- encoding : utf-8 -*-
class User::Parameter < ActiveRecord::Base
  attr_accessible :language, :localization

  belongs_to :user
end
