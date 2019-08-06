# frozen_string_literal: true

# ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  helper_method :turbolinks_app?, :turbolinks_app_version

  # Addition contents for etag
  etag { current_user.try(:id) }
  etag { flash }
  etag { Setting.navbar_html }
  etag { Setting.footer_html }
  etag { Rails.env.development? ? Time.now : Date.current }

  before_action do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)

    if devise_controller?
      devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(*User::ACCESSABLE_ATTRS) }
      devise_parameter_sanitizer.permit(:account_update) do |u|
        u.permit(:email, *User::ACCESSABLE_ATTRS)
      end
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(*User::ACCESSABLE_ATTRS) }
    end

    User.current = current_user
    cookies.signed[:user_id] ||= current_user.try(:id)
  end

  before_action :set_active_menu
  def set_active_menu
    @current = case controller_name
               when "pages"
                 ["/wiki"]
               else
                 ["/#{controller_name}"]
    end
  end

  before_action :set_locale
  def set_locale
    I18n.locale = user_locale

    # after store current locale
    cookies[:locale] = params[:locale] if params[:locale]
  rescue I18n::InvalidLocale
    I18n.locale = I18n.default_locale
  end

  def render_404
    render_optional_error_file(404)
  end

  def render_403
    render_optional_error_file(403)
  end

  def render_optional_error_file(status_code)
    status = status_code.to_s
    fname = %w[404 403 422 500].include?(status) ? status : "unknown"

    respond_to do |format|
      format.html { render template: "/errors/#{fname}", handler: [:erb], status: status, layout: "application" }
      format.all  { render nothing: true, status: status }
    end
  end

  def store_location
    session[:return_to] = request.url
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def redirect_referrer_or_default(default)
    redirect_to(request.referrer || default)
  end

  def authenticate_user!(opts = {})
    return if current_user
    if turbolinks_app?
      render plain: "401 Unauthorized", status: 401
      return
    end

    store_location

    super(opts)
  end
  #
  # def current_user
  #   super
  # end

  def turbolinks_app?
    @turbolinks_app ||= request.user_agent.to_s.include?("turbolinks-app")
  end

  # read turbolinks app version
  # example: version:2.1
  def turbolinks_app_version
    return "" unless turbolinks_app?
    return @turbolinks_app_version if defined? @turbolinks_app_version
    version_str = request.user_agent.to_s.match(/version:[\d\.]+/).to_s
    @turbolinks_app_version = version_str.split(":").last
    @turbolinks_app_version
  end

  # Require Setting enabled module, else will render 404 page.
  def self.require_module_enabled!(name)
    before_action do
      unless Setting.has_module?(name)
        render_404
      end
    end
  end

  private

    def user_locale
      params[:locale] || cookies[:locale] || http_head_locale || Setting.default_locale || I18n.default_locale
    end

    def http_head_locale
      return nil if !Setting.auto_locale?
      http_accept_language.language_region_compatible_from(I18n.available_locales)
    end
end
