class DiscoverController < ApplicationController

  def index
    if params[:search]
      session[:search] = params[:search]
      DiscoverFacade.new(params[:search])
    else
      flash.now[:alert] = "Sorry, couldn't find #{params[:search][:search]}, try again."
    end
  end

  def new
  end

  def create
  # <!-- <div id="JSON" data-info=" <%= discover_facade.json_data %>"></div> -->

  end
end
