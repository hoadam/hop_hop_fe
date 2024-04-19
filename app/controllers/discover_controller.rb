class DiscoverController < ApplicationController

  def index
    @trips = TripService.get_trips(current_user.id)
    if params[:search]
      session[:search] = params[:search]
      DiscoverFacade.new(params[:search])
    else
      flash.now[:alert] = "Sorry, couldn't find #{params[:search][:search]}, try again."
    end
  end

  def new
  end

  def create
    if params[:search][:Type] == "Accommodation"
      redirect_to new_trip_accommodation_path(trip_id: search_params[:Trip], search: session[:search].to_json)
    elsif params[:search][:Type] == "Activity"
      redirect_to daily_itineraries_path(search_params[:Trip])
    else
      flash.now[:error] = "Sorry, try again."
    end
  # <!-- <div id="JSON" data-info=" <%= discover_facade.json_data %>"></div> -->
  end

  def search_params
    params.require(:search).permit(:Trip, :Type)
  end
end
