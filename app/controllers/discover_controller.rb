class DiscoverController < ApplicationController

  def index
    search_location_objects
    json_data
  end

  def new
  end

  def create
  end

  private
  def find_location
    Geocoder.search(params[:search])
  end

  def json_data
    @json_data = find_location.to_json
  end

  def search_location_objects
    @search_objects = find_location.map{|result| Search.new(result.to_json)}
  end
end
  #Adding turboframe tag will not send the session[:search_results]
  # Removing turboframe will mean that the map does not reload
