class AccommodationsController < ApplicationController
  def new
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
    if params[:search].present?
      @accommodation = search_params
    else
      @accommodation = {}
    end
  end

  def create
    begin
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
    @accommodation = AccommodationService.create_accommodation(current_user.id, params[:trip_id], accommodation_params)

    redirect_to trip_path(@trip.id)

    rescue Faraday::BadRequestError => e

      flash[:error] = JSON.parse(e.response[:body], symbolize_names: true)[:errors].first[:detail]
      @accommodation = {}
      render :new
    end
  end

  def edit
    @trip = TripService.trip_details(current_user.id, params[:trip_id])
    @accommodation = AccommodationService.accommodation_details(current_user.id, params[:trip_id], params[:id])
  end

  def update
    begin
      @trip = TripService.trip_details(current_user.id, params[:trip_id])
      @accommodation = AccommodationService.accommodation_details(current_user.id, params[:trip_id], params[:id])
      AccommodationService.update_accommodation(current_user.id, params[:trip_id], params[:id], accommodation_params)

      redirect_to trip_path(@trip.id)
    rescue Faraday::BadRequestError => e
      flash[:error] = "Failed to update accommodation - #{e.message}"
      @accommodation = {}
      render :update
    end
  end

  def destroy
    begin
    AccommodationService.delete_accommodation(current_user.id, params[:trip_id], params[:id])
    redirect_to trip_path(params[:trip_id])
    rescue Faraday::BadRequestError => e
      flash[:error] = "Failed to delete accommodation - #{e.message}"
      redirect_to trip_path(params[:trip_id])
    end
  end

  private

  def accommodation_params
    params.require(:accommodations).permit(:name, :address, :check_in, :check_out, :expenses, :lat, :lon)
  end

  def search_params
    JSON.parse(params.require(:search), symbolize_names: true)
  end
end
