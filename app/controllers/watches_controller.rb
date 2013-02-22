class WatchesController < ApplicationController

  before_filter :require_login

  def index
    @watches = current_user.watches
  end

  def new
  end

  def show
  end

end
