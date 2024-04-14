class DiscoverController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @search = params[:search]
  end
end