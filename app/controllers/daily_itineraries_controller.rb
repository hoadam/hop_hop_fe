class DailyItinerariesController < ApplicationController

  def new
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
    @daily_itineraries = @trip.daily_itineraries
  end

  def create
    begin
      @trip = TripService.trip_details(current_user.id, params[:trip_id])
      ActivityService.create_activity(current_user.id, params[:trip_id], params[:search][:Date], activity_params)

      redirect_to trip_path(@trip.id)

    rescue Faraday::BadRequestError => e
      flash[:error] = JSON.parse(e.response[:body], symbolize_names: true)[:errors].first[:detail]

      redirect_to new_trip_daily_itinerary_path(params[:trip_id])
    end
  end

  private

  def activity_params
    params[:activities] = {
      name: session[:search_results]["displayname"],
      address: session[:search_results]["search"]
    }
  end
end
