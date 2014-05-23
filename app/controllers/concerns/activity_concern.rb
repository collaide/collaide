module Concerns::ActivityConcern

  # Options Hash (options):
  # :action (Symbol, String) — Name of the action
  # :trackable (Activist) — On with model put the track
  # :key (String) — Full key
  # :owner (Activist) — Owner
  # :recipient (Activist) — Recipient
  # :params (Hash) — Parameters, see PublicActivity.resolve_value
  # :type (String) - For inheritance
  # :public - The activity is public
  # :create_related_activity_param (boolean) - If true, we create the activity param

  def create_activity(action, options = {})

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
    if options[:public]
      activity.public = options[:public]
    end
    activity.parameters = options[:params]
    activity.key = get_key(action, options[:trackable])

    if options[:create_related_activity_param] == true
      create_activity_param(activity.trackable, activity.owner)
    end

    activity.save
  end

  # Crée le paramètre pour suivre des activités privées
  # params
  #     trackable: lié a l'objet à suivre
  #     owner: Qui suit cette objet
  #     options :
  #       starting_at : le temps auquel on commence à suivre, default : now
  #       ending_at: Le temps ou la track s'arrête
  def create_activity_param(trackable, owner, options = {})
    param = Activity::Parameter.new
    param.trackable = trackable
    param.owner = owner
    if options[:starting_at]
      param.starting_at = options[:starting_at]
    else
      param.starting_at = Time.now
    end
    if options[:ending_at]
      param.ending_at = options[:ending_at]
    else
      param.ending_at = Time.now + (60*60*24*100000000) # fini dans 100 million d années
    end
    param.save
  end

  def ending_activity_param(trackable, owner)
    param = Activity::Parameter.where(trackable: trackable, owner: owner).take
    param.ending_at = Time.now
    param.save
  end



  private
    def get_key(action, object)
      object.class.name.underscore.gsub('/', '_') + '.' + action.to_s
    end
end