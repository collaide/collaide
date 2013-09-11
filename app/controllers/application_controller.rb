# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base

  #sécu
  protect_from_forgery

  before_filter :set_locale
  before_filter :set_locale_from_url

  #rescue_from ActionController::RoutingError, :with => :render_not_found

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  def render_not_found
    lang = params[:path][/^[a-z]{2}/]
    logger.info I18n.locale


    if lang != I18n.locale.to_s
      logger.info params[:path]
      params[:path][/^[a-z]{2}/] = I18n.locale.to_s
      url = Rails.application.routes.recognize_path(params[:path])
      url[:locale] = lang
       redirect_to url
    else
      redirect_to eval "change_lang_#{lang}_path"
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    if !request.env["HTTP_REFERER"]
      redirect_to root_url
    else
      redirect_to :back, alert: t('access_denied')
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

  add_breadcrumb I18n.t('app_name'), :root_path
end
