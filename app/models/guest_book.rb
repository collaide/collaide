# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: guest_books
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  comment    :text
#  created_at :datetime
#  updated_at :datetime
#

# -*- encoding : utf-8 -*-
class GuestBook < ActiveRecord::Base
  paginates_per 50
  validates :name, presence: true, length: {minimum: 3, maximum: 50}
  validates :comment, presence: true, length: {minimum:3, maximum: 500}#, :uniqueness => {:if => GuestBook.find_by_name(:name)}
end
