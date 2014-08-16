class ApiNotification::ItemDeleted < ApiNotification::ApiNotification

  def as_json(options)
    super(add_only_to_options(options, [:from_path]))
  end
end