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
    begin
      trip = TripService.create_trip(current_user.id, trip_params)

      redirect_to trip_path(trip.id)
    rescue Faraday::BadRequestError => e
      flash[:error] = JSON.parse(e.response[:body], symbolize_names: true)[:errors].first[:detail]

      render :new
    end
  end

  def update
    begin
      @trip = TripService.trip_details(current_user.id, params[:id])
      TripService.update_trip(current_user.id, params[:id], trip_params)
      redirect_to trip_path(@trip.id)

    rescue Faraday::BadRequestError => e
      flash[:error] = JSON.parse(e.response[:body], symbolize_names: true)[:errors].first[:detail]

      render :show
    end
  end

  def destroy
    begin
      TripService.delete_trip(current_user.id, params[:id] )
      redirect_to dashboard_path(current_user.id)
    rescue Faraday::BadRequestError => e
      flash[:error] = JSON.parse(e.response[:body], symbolize_names: true)[:errors].first[:detail]

      redirect_to dashboard_path(current_user.id)
    end
  end


  private

  def trip_params
    params.require(:trip).permit(:name, :location, :start_date, :end_date, :total_budget, :lat, :lon)
  end
end
