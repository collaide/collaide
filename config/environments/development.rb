# -*- encoding : utf-8 -*-
Collaide::Application.configure do
  #Custom logging
  # Optional, defaults to '0.0.0.0'
  config.logstash.host = 'dev.collaide.com'

# Optional, defaults to :udp.
  config.logstash.type = :udp

# Required, the port to connect to
  config.logstash.port = 6379

  config.lograge.enabled = true
  config.lograge.formatter = Lograge::Formatters::Logstash.new

###############################################################################################


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
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Expands the lines which load the assets
  config.assets.debug = true

  config.action_mailer.default_url_options = {:host => 'localhost:3000'}
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {:address => 'localhost', :port => 1025}

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :silence
  config.log_level = :debug

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
