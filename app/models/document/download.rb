class Document::Download < ActiveRecord::Base
  belongs_to :user
  belongs_to :document, :class_name => 'Document::Document'
end
