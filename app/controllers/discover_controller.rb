class DiscoverController < ApplicationController

  def index
    session[:search] = params[:search] if params[:search]
    if discover_facade.empty? && params[:search]
      flash[:alert] = "Sorry, couldn't find #{params[:search]}, try again."
    end
  end

  def new
  end

  def create
  end
end
