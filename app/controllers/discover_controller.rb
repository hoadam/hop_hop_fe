class DiscoverController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @search = params[:search]
    find_location
  end

  def new
    find_location
  end

  def create
  end

  def find_location
    results = Geocoder.search(params[:search])
    @array = results.to_json
  end
end
  #Adding turboframe tag will not send the session[:search_results]
  # Removing turboframe will mean that the map does not reload
