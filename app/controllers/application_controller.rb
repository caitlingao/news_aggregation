class ApplicationController < ActionController::Base
  helper_method :turbolinks_app?
  before_action :set_active_menu
  def set_active_menu
    @current = ["/#{controller_name}"]
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

  def current_user
    super
  end

  def turbolinks_app?
    @turbolinks_app ||= request.user_agent.to_s.include?("turbolinks-app")
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
end
