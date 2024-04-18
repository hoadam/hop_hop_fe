class DiscoverController < ApplicationController

  def index
    session[:search] = params[:search] if params[:search]
    if discover_facade.empty? && params[:search]
      flash.now[:alert] = "Sorry, couldn't find #{params[:search][:search]}, try again."
    end
  end

  def new
  end

  def create
  end
end
