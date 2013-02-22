class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_user

  def require_login
    if !current_user
      redirect_to '/' and return
    end
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      false
    end
  end
end
