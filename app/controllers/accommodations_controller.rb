class AccommodationsController < ApplicationController
  def new
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
  end

  def create
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
    @accommodation = AccommodationService.create_accommodation(current_user.id, params[:trip_id], accommodation_params)

    redirect_to trip_path(@trip.id)
  end

  def edit
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
    @accommodation = AccommodationService.accommodation_details(current_user.id, params[:trip_id], params[:id])
  end

  def update
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
    @accommodation = AccommodationService.accommodation_details(current_user.id, params[:trip_id], params[:id])

    AccommodationService.update_accommodation(current_user.id, params[:trip_id], params[:id], accommodation_params)

    redirect_to trip_path(@trip.id)
  rescue => e
    flash[:error] = "Failed to update accommodation - #{e.message}"
  end

  def destroy
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
    @accommodation = AccommodationService.accommodation_details(current_user.id, params[:trip_id], params[:id])
    AccommodationService.delete_accommodation(current_user.id, params[:trip_id], params[:id])
  rescue => e
    flash[:error] = "Failed to delete accommodation - #{e.message}"
  end

  private

  def accommodation_params
    params.require(:accommodations).permit(:name, :address, :check_in, :check_out, :expenses)
  end
end
