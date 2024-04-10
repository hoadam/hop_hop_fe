class UsersController < ApplicationController
  before_action :require_user, except: [:new, :create]

  def show
    @user = User.find(params[:id])
  end

  private

  def require_user
    user_id = params[:id]
    return if current_user && current_user.id == user_id.to_i

    flash[:notice] = "You must be logged in or registered to access a user's dashboard"
    redirect_to root_path
  end
end
