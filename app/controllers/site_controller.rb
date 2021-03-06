class SiteController < ApplicationController
  def index
  end

  def login
    data = env["omniauth.auth"]
    p data['info']
    email = data['info'].email
    login = data['info'].nickname
    if login
      user = User.find_or_create_by_login(login)
      user.email = email
      user.save
      session[:user_id] = user.id
    end
    redirect_to '/watches'
  end

  def logout
    session[:user_id] = nil
    redirect_to '/'
  end
end
