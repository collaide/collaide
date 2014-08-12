class ApiNotification::ItemChanged < ApiNotification::ApiNotification
  def as_json(options)
    super(add_only_to_options(options, [:notifier_id, :from_path]))
  end
end