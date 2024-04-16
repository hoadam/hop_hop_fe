class DiscoverController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @search = params[:search]
    @results = search_location
  end

  def new
  end

  def create
  end

  def search_location
    results = Geocoder.search(params[:search])
    results.map{|result| Search.new(result.to_json)}
  end
end
  #Adding turboframe tag will not send the session[:search_results]
  # Removing turboframe will mean that the map does not reload
