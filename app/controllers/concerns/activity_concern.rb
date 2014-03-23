module Concerns::ActivityConcern

  # Options Hash (options):
  # :action (Symbol, String) — Name of the action
  # :trackable (Activist) — On with model put the track
  # :key (String) — Full key
  # :owner (Activist) — Owner
  # :recipient (Activist) — Recipient
  # :params (Hash) — Parameters, see PublicActivity.resolve_value

  def create_activity(action, options = {})
    activity = Activity::Activity.new
    activity.trackable = options[:trackable]
    activity.owner = options[:owner]
    activity.recipient = options[:recipient]
    activity.parameters = options[:params]
    activity.key = get_key(action, options[:trackable])
    activity.save
  end

  private
    def get_key(action, object)
      object.class.name.underscore.gsub('/', '_') + '.' + action.to_s
    end
end