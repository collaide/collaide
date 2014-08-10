class ApiNotification < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  belongs_to :notifier, polymorphic: true
  #
  scope :find_for_api, ->(last_seen, type) {
    requets = nil
    if last_seen and type.nil?
      request = where('created_at < ?', last_seen)
    elsif type and last_seen.nil?
      request = where(notification_type: type)
    elsif last_seen and type
      request = where(notification_type: type).where('created_at < ?', last_seen)
    else

    end
    if request
      request.includes(:notifier)
    else
      includes(:notifier)
    end
  }
end
