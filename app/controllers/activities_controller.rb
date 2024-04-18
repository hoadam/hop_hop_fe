class ActivitiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @trip = TripService.trip_details(params[:user_id], params[:trip_id])
  end

  def create
    @user = User.find(params[:user_id])
    @trip = TripService.trip_details(params[:user_id], params[:trip_id])
    @activity = ActivityService.create_activity(params[:user_id], params[:trip_id], params[:daily_itinerary_id], activity_params)
    redirect_to user_trip_path(@user, @trip.id)
  end

  def edit
    @user = User.find(params[:user_id])
    @trip = TripService.trip_details(params[:user_id], params[:trip_id])
    @activity = ActivityService.activity_details(params[:user_id], params[:trip_id], params[:daily_itinerary_id], params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @trip = TripService.trip_details(params[:user_id], params[:trip_id])
    @activity = ActivityService.activity_details(params[:user_id], params[:trip_id], params[:daily_itinerary_id], params[:id])

    ActivityService.update_activity(params[:user_id], params[:trip_id], params[:daily_itinerary_id], params[:id], activity_params)
    redirect_to user_trip_path(@user, @trip.id)
  rescue => e
    flash[:error] = "Failed to update activity - #{e.message}"
    redirect_to edit_user_trip_daily_itinerary_activity_path(params[:user_id], params[:trip_id], params[:daily_itinerary_id], params[:id])
  end

  def destroy
    @user = User.find(params[:user_id])
    @trip = TripService.trip_details(params[:user_id], params[:trip_id])
    @activity = ActivityService.activity_details(params[:user_id], params[:trip_id], params[:daily_itinerary_id], params[:id])

    ActivityService.delete_activity(params[:user_id], params[:trip_id], params[:daily_itinerary_id], params[:id])

    redirect_to user_trip_path(@user, @trip.id)
  rescue => e

    flash[:error] = "Failed to delete accommodation - #{e.message}"
    redirect_to user_trip_path(@user, @trip.id)
  end

  private

  def activity_params
    params.permit(:name, :address, :expenses, :description, :lat, :lon)
  end
end
