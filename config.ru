# This fichier is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
use Rack::Deflater
use Rack::CanonicalHost, 'www.collaide.com' if Rails.env == 'production'
run Collaide::Application
