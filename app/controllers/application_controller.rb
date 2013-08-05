class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  before_filter :set_locale_from_url

  rescue_from CanCan::AccessDenied do |exception|
    if !request.env["HTTP_REFERER"]
      redirect_to root_url
    else
      redirect_to :back, notice: exception.message
    end
  end

  protected
  def user_for_paper_trail
    user_signed_in? ? current_user : 'Unknown user'
  end

  private

  def set_locale
    I18n.locale = params[:locale] || ((lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/])
    logger.info "lang set to '#{I18n.locale}'"
  end
end
