module Concerns::ActivityConcern

  # Options Hash (options):
  # :action (Symbol, String) — Name of the action
  # :trackable (Activist) — On with model put the track
  # :key (String) — Full key
  # :owner (Activist) — Owner
  # :recipient (Activist) — Recipient
  # :params (Hash) — Parameters, see PublicActivity.resolve_value
  # :type (String) - For inheritance

  def create_activity(action, options = {})
    if options[:type]
      case options[:type]
        when :workgroup
          activity = Activity::WorkGroupActivity.new
        else
          activity = Activity::Activity.new
      end
    else
      activity = Activity::Activity.new
    end
    activity = Activity::Activity.new
    activity.trackable = options[:trackable]
    if options[:owner]
      activity.owner = options[:owner]
    elsif options[:owner_id] && options[:owner_type]
      activity.owner_id = options[:owner_id]
      activity.owner_type = options[:owner_type]
    end
    if options[:recipient]
      activity.recipient = options[:recipient]
    elsif options[:recipient_id] && options[:recipient_type]
      activity.recipient_id = options[:recipient_id]
      activity.recipient_type = options[:recipient_type]
    end
    activity.parameters = options[:params]
    activity.key = get_key(action, options[:trackable])
    activity.save
  end

  private
    def get_key(action, object)
      object.class.name.underscore.gsub('/', '_') + '.' + action.to_s
    end
end