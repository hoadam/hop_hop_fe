class AccommodationsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @trip = TripService.trip_details(params[:user_id], params[:trip_id])
  end

  def create
    @user = User.find(params[:user_id])
    @trip = TripService.trip_details(params[:user_id], params[:trip_id])
    @accommodation = AccommodationService.create_accommodation(params[:user_id], params[:trip_id], accommodation_params)
    redirect_to user_trip_path(@user, @trip.id)
  end

  def edit
    @user = User.find(params[:user_id])
    @trip = TripService.trip_details(params[:user_id], params[:trip_id])
    @accommodation = AccommodationService.accommodation_details(params[:user_id], params[:trip_id], params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @trip = TripService.trip_details(params[:user_id], params[:trip_id])
    @accommodation = AccommodationService.accommodation_details(params[:user_id], params[:trip_id], params[:id])

    AccommodationService.update_accommodation(params[:user_id], params[:trip_id], params[:id], accommodation_params)
    redirect_to user_trip_path(@user, @trip.id)
  rescue => e
    flash[:error] = "Failed to update accommodation - #{e.message}"
    redirect_to edit_user_trip_accommodation_path(@user, @trip.id, @accommodation.id)
  end

  def destroy
    @user = User.find(params[:user_id])
    @trip = TripService.trip_details(params[:user_id], params[:trip_id])
    @accommodation = AccommodationService.accommodation_details(params[:user_id], params[:trip_id], params[:id])
    AccommodationService.delete_accommodation(params[:user_id], params[:trip_id], params[:id])
    redirect_to user_trip_path(@user, @trip.id)
  rescue => e
    flash[:error] = "Failed to delete accommodation - #{e.message}"
    redirect_to user_trip_path(@user, @trip.id)
  end

  private

  def accommodation_params
    params.permit(:name, :address, :check_in, :check_out, :expenses)
  end
end
