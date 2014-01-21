# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: advertisement_advertisements
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  active      :boolean
#  type        :string(255)
#  price       :decimal(9, 2)
#  currency    :string(255)
#  state       :string(255)
#  annotation  :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  language    :string(255)
#  book_id     :integer
#  hits        :integer          default(0)
#

# -*- encoding : utf-8 -*-
class Advertisement::Advertisement < ActiveRecord::Base

  validates_presence_of :title

  #Liaisons
  belongs_to :user

end
