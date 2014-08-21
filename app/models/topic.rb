# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  title       :string(255)
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

  belongs_to :user_writer, -> { where('topics.writer_type = User') }, foreign_key: 'writer_id', class_name: 'User'
  validates_presence_of :message

  def to_s
    if title.blank?
      ActionController::Base.helpers.strip_tags(message).truncate(30).html_safe
    else
      title
    end
  end
end
