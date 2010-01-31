# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation

 # before_filter :require_user
  before_filter :set_time_zone
  before_filter :set_locale

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to "/login" #new_user_session_url
      return false
    end
  end

  def require_admin
    return false unless current_user
    current_user.admin?
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  # pt_br , en_us
  def get_browser_locale
    request.env["HTTP_ACCEPT_LANGUAGE"].split("-")[0]
  end

  def set_locale
    locale = current_user.locale if current_user
    I18n.locale = locale || get_browser_locale || params[:locale] || I18n.default_locale
    I18n.load_path += Dir[ File.join(RAILS_ROOT, 'lib', 'locale', '*.{rb,yml}') ]
  end

  def set_time_zone
    Time.zone = current_user.time_zone if current_user
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
