# -*- encoding : utf-8 -*-
Collaide::Application.configure do
  #Custom logging
  
  # Enable the logstasher logs for the current environment
   config.logstasher.enabled = true
  #
  # # This line is optional if you do not want to suppress app logs in your <environment>.log
   config.logstasher.suppress_app_log = false
  #
  # # This line is optional, it allows you to set a custom value for the @source field of the log event
   config.logstasher.source = 'collaide.com'


  # Settings specified here will take precedence over those in config/application.rb
  # OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  config.eager_load = false
  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Expands the lines which load the assets
  config.assets.debug = true

  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
   config.action_mailer.delivery_method = :smtp
   config.action_mailer.smtp_settings = { :address => 'localhost', :port => 1025 }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  #config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.serve_static_assets = true
  Paperclip.options[:command_path] = "/opt/ImageMagick/bin"
end
