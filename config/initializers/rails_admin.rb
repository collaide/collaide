require 'i18n'
I18n.default_locale = :fr
RailsAdmin.config do |config|
  config.main_app_name = ["Cool app", "BackOffice"]
  # or somethig more dynamic
  config.main_app_name = Proc.new { |controller| [ "Cool app", "BackOffice - #{controller.params[:action].try(:titleize)}" ] }
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method &:current_user
  config.authorize_with :cancan
end