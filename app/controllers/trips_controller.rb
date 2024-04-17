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

  def edit
    @user = User.find(params[:user_id])
    @trip = TripService.trip_details(params[:user_id], params[:id])
  end

  def update
    @user = User.find(params[:user_id])

    @trip = TripService.trip_details(params[:user_id], params[:id])

    TripService.update_trip(params[:user_id], params[:id], trip_params)
    redirect_to user_trip_path(@user, @trip.id)
  rescue
    flash[:error] = "Failed to update trip"
    redirect_to edit_user_trip_path(@user, @trip.id)
  end

  def destroy
    TripService.delete_trip(current_user.id, params[:id] )
    redirect_to user_path(current_user.id)
  end


  private

  def trip_params
    params.permit(:name, :location, :start_date, :end_date, :total_budget)
  end
end
