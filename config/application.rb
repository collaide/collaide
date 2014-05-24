# -*- encoding : utf-8 -*-
require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
 # Bundler.require(*Rails.advertisements(:assets => %w(development test)))
 # Require the gems listed in Gemfile, including any gems
 # you've limited to :test, :development, or :production.
  Bundler.require(:default, Rails.env)

  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Collaide
  class Application < Rails::Application

    config.action_view.sanitized_allowed_tags = 'table', 'tr', 'td'
    #config.action_view.sanitized_allowed_attributes = ['style']

    #config.exceptions_app = self.routes

    # Custom logging
  # Enable the logstasher logs for the current environment
   config.logstasher.enabled = true
  #
  # # This line is optional if you do not want to suppress app logs in your <environment>.log
   config.logstasher.suppress_app_log = false
  #
  # # This line is optional, it allows you to set a custom value for the @source field of the log event
   config.logstasher.source = 'collaide.com'

    # ATTENTION Ajouter pour contrer le bug de GoogleBooks
    # Je l'ai mis dans environnements/development.rb --> comme ça le serveur prod ne quinte pas.
    # Et Si ça bug en production, je dois pouvoir le configurer facilement
    #OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/lib)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
     config.time_zone = 'Paris'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
     config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
     config.i18n.default_locale = :fr
     config.i18n.available_locales = [:fr, :en]
    # uncomment this 3 lines to have multi linguale site do it to application_controller.rb, too
    #if Rails.env == 'development'
    #  config.i18n.available_locales = [:fr, :en]
    #end

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log fichier.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    #config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true
    social_keys = File.join(Rails.root, 'config', 'social_keys.yml')
    CONFIG = HashWithIndifferentAccess.new(YAML::load(IO.read(social_keys)))[Rails.env]
    CONFIG.each do |k,v|
      ENV[k.upcase] ||= v
    end


    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # Enable observers
    config.active_record.observers = :'document/document_observer', :'advertisement/advertisement_observer',
        :'group/invitation_observer', :'repository_manager/repo_item_observer', :topic_observer, :comment_observer,
        :user_observer

  end
end
