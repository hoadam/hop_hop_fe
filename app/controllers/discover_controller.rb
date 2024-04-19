class DiscoverController < ApplicationController

  def index
    if params[:search_results].present? && filter_search.empty?
      @trips = nil
      flash.now[:alert] = "Sorry, enter a search"
    elsif params[:search_results].present?
      @trips = TripService.get_trips(current_user.id)
      session[:search_results] = params[:search_results]
      @search = Search.new(params[:search_results])
    else
      @trips = nil
    end
  end

  def new
  end

  def create
    if params[:search_results][:type] == "Accommodation"

      redirect_to new_trip_accommodation_path(trip_id: search_params[:Trip], search: session[:search_results].to_json)
    elsif params[:search_results][:type] == "Activity"

      redirect_to new_trip_daily_itinerary_path(search_params[:Trip])
    else
      flash[:alert] = "Sorry, please make sure all fields are selected"

      redirect_to discover_index_path
    end
  end

  def search_params
    params = params.require(:search_results)
  end

  def filter_search
    params[:search_results].values.delete_if(&:empty?)
  end
end
