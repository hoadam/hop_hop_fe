class DiscoverController < ApplicationController

  def index
    filtered_search_objects
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
    find_location.map{|result| Search.new(result)}
  end

  def filtered_search_objects
    @search_objects = search_location_objects.uniq {|object| object.display_name}
  end
end
  #Adding turboframe tag will not send the session[:search_results]
  # Removing turboframe will mean that the map does not reload
