class TripsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @trips = TripService.get_trips(params[:user_id])
  end

  def show
    @user = User.find(params[:user_id])

    @accommodations = AccommodationService.get_accommodations(params[:user_id], params[:id])

    @trip = TripService.trip_details(params[:user_id], params[:id])

    @daily_itineraries = @trip.daily_itineraries
    @activities = @trip.activities
  end


end
