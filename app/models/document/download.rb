# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: document_downloads
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  document_documents_id :integer
#  number_of_downloads   :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class Document::Download < ActiveRecord::Base
  belongs_to :user
  belongs_to :document, :class_name => 'Document::Document'
end
