# == Schema Information
#
# Table name: api_notifications
#
#  id                :integer          not null, primary key
#  owner_type        :string(255)
#  owner_id          :integer
#  notification_type :string(255)
#  notifier_type     :string(255)
#  notifier_id       :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class ApiNotification::ApiNotification < ActiveRecord::Base
  belongs_to :owner, polymorphic: true
  belongs_to :notifier, polymorphic: true
  # recherche des notification à partir de la dernière consultation (optionel)
  scope :find_for_api, ->(last_seen = nil, type = nil) {
    request = self
    unless last_seen.blank?
      request = request.where('created_at > ?', last_seen)
    end
    unless type.blank?
      request = request.where(type: type)
    end
    request.includes(:notifier)
  }

  def as_json(options)
    super(add_only_to_options(options, [:notifier_type, :type]))
  end

  protected

  def add_only_to_options(options, more_only)
    only = options[:only] ||= []
    options[:only] = only + more_only
    options
  end
end
