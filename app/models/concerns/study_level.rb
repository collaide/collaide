require 'active_support/concern'
module Concerns::StudyLevel  extend  ActiveSupport::Concern
  module ClassMethods
    def enumerize_study_level
      enumerize :study_level, in: [:university, :college]
    end
  end
end