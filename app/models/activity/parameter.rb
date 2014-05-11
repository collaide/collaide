class Activity::Parameter < ActiveRecord::Base

  #before_save :encode_condition

  validates :trackable, presence: true
  validates :owner, presence: true

  belongs_to :owner, polymorphic: true
  belongs_to :trackable, polymorphic: true


  #scope :activities,
  #  -> {where('
  #      (activity_activities.trackable_id = ? AND activity_activities.trackable_type = ?)
  #    OR
  #      (activity_activities.recipient_id = ? AND activity_activities.recipient_type = ?)
  #    AND (
  #        activity_activities.created_at >= activity_params.starting_at
  #      AND
  #        activity_activities.created_at <= activity_params.ending_at
  #    )',
  #    self.object.id, self.object.class.base_class.to_s, self.object.id, self.object.class.base_class.to_s )},
  #  class_name: 'Activity::Activity'

  #def encode_condition
  #
  #end
end
