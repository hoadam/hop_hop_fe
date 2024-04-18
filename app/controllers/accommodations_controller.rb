class AccommodationsController < ApplicationController
  def new
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
  end

  def create
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
    @accommodation = AccommodationService.create_accommodation(current_user.id, params[:trip_id], accommodation_params)
  end

  def edit
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
    @accommodation = AccommodationService.accommodation_details(current_user.id, params[:trip_id], params[:id])
  end

  def update
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
    @accommodation = AccommodationService.accommodation_details(current_user.id, params[:trip_id], params[:id])
    AccommodationService.update_accommodation(current_user.id, params[:trip_id], params[:id], accommodation_params)
  rescue => e
    flash[:error] = "Failed to update accommodation - #{e.message}"
  end

  def destroy
    AccommodationService.delete_accommodation(current_user.id, params[:trip_id], params[:id])
    redirect_to trip_path(params[:trip_id])
  rescue => e
    flash[:error] = "Failed to delete accommodation - #{e.message}"
    redirect_to trip_path(params[:trip_id])
  end

  private

  def accommodation_params
    params.permit(:name, :address, :check_in, :check_out, :expenses, :lat, :lon)
  end
end
