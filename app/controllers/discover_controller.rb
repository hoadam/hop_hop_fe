class DiscoverController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @search = params[:search]
    find_location
  end

  def find_location
    results = Geocoder.search(params[:search])
    @array = results.to_json
  end
end
