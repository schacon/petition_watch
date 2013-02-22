class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      false
    end
  end
end
