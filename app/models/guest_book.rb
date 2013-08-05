class GuestBook < ActiveRecord::Base
  attr_accessible :comment, :name
  paginates_per 5
  validates :name, presence: true, length: {minimum: 3, maximum: 50}
  validates :comment, presence: true, length: {minimum:3, maximum: 500}, :uniqueness => {:if => GuestBook.find_by_name(:name)}
end
