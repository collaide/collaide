# == Schema Information
#
# Table name: guest_books
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# -*- encoding : utf-8 -*-
class GuestBook < ActiveRecord::Base
  attr_accessible :comment, :name
  paginates_per 5
  validates :name, presence: true, length: {minimum: 3, maximum: 50}
  validates :comment, presence: true, length: {minimum:3, maximum: 500}, :uniqueness => {:if => GuestBook.find_by_name(:name)}
end
