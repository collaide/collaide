# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base

  #sécu
  protect_from_forgery

  before_filter :set_locale
  before_filter :get_documents

  #rescue_from ActionController::RoutingError, :with => :render_not_found

  before_filter :store_location

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if (request.fullpath != new_user_session_path &&
        request.fullpath != new_user_registration_path &&
        request.fullpath != user_password_path &&
        request.fullpath != destroy_user_session_path &&
        request.fullpath != user_registration_path &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    flash[:login_out] = 'true'
    logger.debug(flash[:login_out])
    session[:previous_url] || root_path
  end

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

  def view_context
    super.tap do |view|
      (@_content_for || {}).each do |name,content|
        view.content_for name, content
      end
    end
  end

  def content_for(name, content) # no blocks allowed yet
    @_content_for ||= {}
    if @_content_for[name].respond_to?(:<<)
      @_content_for[name] << content
    else
      @_content_for[name] = content
    end
  end

  def content_for?(name)
    @_content_for[name].present?
  end

  rescue_from CanCan::AccessDenied do |exception|
    if !request.env["HTTP_REFERER"] || !flash[:notice].nil?
      redirect_to root_url
    else
      redirect_to user_session_path, alert: t('access_denied')
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
    add_breadcrumb(I18n.t('app_name'), :root_path)
  end

  def get_documents
    @footer_document = Document::Document.valid.order('created_at DESC').limit(6).all
  end
end
