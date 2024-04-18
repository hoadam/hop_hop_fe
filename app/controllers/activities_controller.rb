class ActivitiesController < ApplicationController
  def new
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
  end

  def create
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
    @activity = ActivityService.create_activity(current_user.id, params[:trip_id], params[:daily_itinerary_id], activity_params)
    redirect_to trip_path(@trip.id)
  end

  def edit
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
    @activity = ActivityService.activity_details(current_user.id, params[:trip_id], params[:daily_itinerary_id], params[:id])
  end

  def update
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
    @activity = ActivityService.activity_details(current_user.id, params[:trip_id], params[:daily_itinerary_id], params[:id])
    ActivityService.update_activity(current_user.id, params[:trip_id], params[:daily_itinerary_id], params[:id], activity_params)
    redirect_to trip_path(@trip.id)
  rescue => e
    flash[:error] = "Failed to update activity - #{e.message}"
    redirect_to edit_trip_daily_itinerary_activity_path(current_user.id, params[:trip_id], params[:daily_itinerary_id], params[:id])
  end

  def destroy
    ActivityService.delete_activity(current_user.id, params[:trip_id], params[:daily_itinerary_id], params[:id])
    redirect_to trip_path(params[:trip_id])
  rescue => e
    flash[:error] = "Failed to delete accommodation - #{e.message}"
    redirect_to trip_path(params[:trip_id])
  end

  private

  def activity_params
    params.require(:activities).permit(:name, :address, :expenses, :description)
  end
end
