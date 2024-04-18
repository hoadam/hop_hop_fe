class TripsController < ApplicationController
  def index
    @trips = TripService.get_trips(current_user.id)
  end

  def show
    @accommodations = AccommodationService.get_accommodations(current_user.id, params[:id])

    @trip = TripService.trip_details(current_user.id, params[:id])

    @daily_itineraries = @trip.daily_itineraries
    @activities = @trip.activities
  end

  def edit
    @trip = TripService.trip_details(current_user.id, params[:id])
  end

  def new
  end

  def create
    trip = TripService.create_trip(current_user.id, trip_params)
    if trip.is_a?(String)
      flash[:alert] = "Make sure you have filled out all fields correctly"
      render :new
    else
      redirect_to trip_path(trip.id)
    end
  end

  def update
    @trip = TripService.trip_details(current_user.id, params[:id])

    TripService.update_trip(current_user.id, params[:id], trip_params)
    redirect_to trip_path(@trip.id)
  rescue
    flash[:error] = "Failed to update trip"
  end

  def destroy
    TripService.delete_trip(current_user.id, params[:id] )
    redirect_to dashboard_path(current_user.id)
  rescue => e
    flash[:error] = "Failed to delete trip- #{e.message}"
    redirect_to dashboard_path(current_user.id)
  end


  private

  def trip_params
    params.permit(:name, :location, :start_date, :end_date, :total_budget)
  end
end
