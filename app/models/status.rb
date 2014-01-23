# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: User_statuses
#
#  id              :integer          not null, primary key
#  content         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  owner           :reference
#

# -*- encoding : utf-8 -*-
class Status < ActiveRecord::Base

  belongs_to :owner, polymorphic: true, inverse_of: :statuses
end
