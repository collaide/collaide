# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base

  #sécu
  protect_from_forgery

  prepend_before_action :auth_token_user
  before_action do
    resource = controller_path.singularize.gsub('/', '_').to_sym # => 'blog/posts' => 'blog/post' => 'blog_post' => :blog_post
    method = "#{resource}_params" # => 'blog_post_params'
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  before_action do
    ObserverHelpers.current_user = current_user
  end

  before_action :set_locale

    #rescue_from ActionController::RoutingError, :with => :render_not_found

  before_action :store_location
  before_action :current_ability

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if(request.fullpath.start_with? '/admin' or request.post?)
      return
    end
    if (request.fullpath != new_user_session_path &&
        request.fullpath != new_user_registration_path &&
        request.fullpath != user_password_path &&
        request.fullpath != destroy_user_session_path &&
        request.fullpath != user_registration_path &&
        !request.fullpath.start_with?(edit_user_password_path) &&
        !request.fullpath.start_with?('/users/auth/') &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
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
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    can_can_access_denied
  end

  protected
  def can_can_access_denied
    if !request.env["HTTP_REFERER"] and params[:work_group_id] and params[:secret_token] and params[:id] and current_user.nil?
      redirect_to user_session_path, alert: t('access_denied')
    elsif !request.env["HTTP_REFERER"] || !flash[:notice].nil?
      redirect_to main_app.root_url, alert: t('not_enough_role')
    elsif request.env['HTTP_REFERER'] and !current_user.nil?
      redirect_to :back, alert: t('not_enough_role')
    elsif current_user.nil?
      redirect_to user_session_path, alert: t('access_denied')
    end
  end
  #def user_for_paper_trail
  #  user_signed_in? ? current_user : 'Unknown user'
  #end

  def back
    return root_path unless request.env['HTTP_REFERER']
    :back
  end

  private

  def sign_in_user
    raise CanCan::AccessDenied if current_user.nil?
  end

  def auth_token_user
    if !params[:user_email].blank? and (user = User.find_by(email: params[:user_email]))
      if Devise.secure_compare(user.authentication_token, params[:user_token])
        sign_in user, store: false
        logger.debug('asDFsdfasdfsad')
      end
    end
  end
  def set_locale
    I18n.locale = :fr
    # uncomment this line to have multi linguale site do it to config/application.rb, too
    #I18n.locale = params[:locale] || ((lang = request.env['HTTP_ACCEPT_LANGUAGE']) && lang[/^[a-z]{2}/]) if Rails.env == 'development'
    #logger.info "lang set to '#{I18n.locale}'"
    add_breadcrumb(I18n.t('app_name'), :root_path)
  end

  def current_ability

    @current_ability ||= Ability.new(current_user, request)
  end
end
