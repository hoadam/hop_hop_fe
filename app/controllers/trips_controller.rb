class TripsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @trips = TripService.get_trips(params[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @trip = TripService.trip_details(params[:user_id], params[:id])
    @activities = Activity.daily_activities(params[:user_id], params[:id])
  end
end
