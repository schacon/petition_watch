class SiteController < ApplicationController
  def login
    p access_token = env["omniauth.auth"]
    redirect_to '/'
  end

  def index
  end
end
