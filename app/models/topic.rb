# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: threads
#
#  id          :integer          not null, primary key
#  message     :text
#  owner_id    :integer
#  owner_type  :string(255)
#  writer_id   :integer
#  writer_type :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

# -*- encoding : utf-8 -*-
class Topic < ActiveRecord::Base

  acts_as_commentable
  #include PublicActivity::Common

  belongs_to :owner, polymorphic: true, inverse_of: :topics
  belongs_to :writer, polymorphic: true

  validates_presence_of :message
end
