class DiscoverController < ApplicationController

  def index
    if params[:search]
      @trips = TripService.get_trips(current_user.id)
      session[:search] = params[:search]
      DiscoverFacade.new(params[:search])
    else
      @trips = nil
    end
  end

  def new
  end

  def create
    if params[:search][:Type] == "Accommodation"
      redirect_to new_trip_accommodation_path(trip_id: search_params[:Trip], search: session[:search].to_json)
    elsif params[:search][:Type] == "Activity"
      redirect_to new_trip_daily_itinerary_path(search_params[:Trip])
    else
      flash.now[:error] = "Sorry, try again."
    end
  end

  def search_params
    params.require(:search).permit(:Trip, :Type)
  end
end
