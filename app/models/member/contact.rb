# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: member_contacts
#
#  id            :integer          not null, primary key
#  first_name    :string(255)
#  last_name     :string(255)
#  date_of_birth :date
#  gender        :string(255)
#  users_id      :integer
#  created_at    :datetime
#  updated_at    :datetime
#

# -*- encoding : utf-8 -*-
class Member::Contact < ActiveRecord::Base

  belongs_to :user
end
