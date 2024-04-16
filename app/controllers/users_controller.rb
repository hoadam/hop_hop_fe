class UsersController < ApplicationController
  # before_action :require_user, except: [:new, :create]

  def show
    @user = User.find(params[:id]).decorate
  end

  # def new
  #   @user = User.new
  # end

  # def create
  #   user_params[:email] = user_params[:email].downcase
  #   user = User.new(user_params)
  #   if user.save
  #     session[:user_id] = user.id
  #     redirect_to user_path(user)
  #   else
  #     flash[:error] = "#{error_message(user.errors)}"
  #     redirect_to register_user_path
  #   end
  # end

  private

  # def user_params
  #   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  # end

  # def require_user
  #   user_id = params[:id]
  #   return if current_user && current_user.id == user_id.to_i

  #   flash[:notice] = "You must be logged in or registered to access a user's dashboard"
  #   redirect_to root_path
  # end
end
