class WatchesController < ApplicationController
  before_filter :require_login

  # GET /watches
  # GET /watches.json
  def index
    @watches = current_user.watches

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @watches }
    end
  end

  # GET /watches/1
  # GET /watches/1.json
  def show
    @watch = current_user.watches.find(params[:id])
    @petitions = @watch.petitions

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @watch }
    end
  end

  # GET /watches/new
  # GET /watches/new.json
  def new
    @watch = Watch.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @watch }
    end
  end

  # POST /watches
  # POST /watches.json
  def create
    @watch = Watch.new(params[:watch])
    @watch.user = current_user
    respond_to do |format|
      if @watch.save
        @watch.find_matches
        format.html { redirect_to @watch, notice: 'Here are your results.  Any future matches will be emailed to you.' }
        format.json { render json: @watch, status: :created, location: @watch }
      else
        format.html { render action: "new" }
        format.json { render json: @watch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /watches/1
  # DELETE /watches/1.json
  def destroy
    @watch = current_user.watches.find(params[:id])
    @watch.destroy

    respond_to do |format|
      format.html { redirect_to watches_url }
      format.json { head :no_content }
    end
  end
end
