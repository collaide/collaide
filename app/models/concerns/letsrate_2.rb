require 'active_support/concern'
module Concerns::Letsrate_2  extend  ActiveSupport::Concern
  module ClassMethods
    def letsrate_rateable_2(*dimensions)

      has_many :rates_without_dimension, -> { where dimension: nil}, :as => :rateable, :class_name => "Rate", :dependent => :destroy
      has_many :raters_without_dimension, :through => :rates_without_dimension, :source => :rater

      has_one :rate_average_without_dimension, -> { where dimension: nil}, :as => :cacheable,
              :class_name => "RatingCache", :dependent => :destroy


      dimensions.each do |dimension|
        has_many "#{dimension}_rates".to_sym, -> {where dimension: dimension.to_s},
                 :dependent => :destroy,
                 :class_name => "Rate",
                 :as => :rateable

        has_many "#{dimension}_raters".to_sym, :through => "#{dimension}_rates".to_sym, :source => :rater, source_type: "User"

        has_one "#{dimension}_average".to_sym, -> { where dimension: dimension.to_s },
                :as => :cacheable, :class_name => "RatingCache",
                :dependent => :destroy
      end

    end
  end
end