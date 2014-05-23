# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: document_downloads
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  document_id         :integer
#  number_of_downloads :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class Document::Download < ActiveRecord::Base
  belongs_to :user
  belongs_to :document, :class_name => 'Document::Document'
end
