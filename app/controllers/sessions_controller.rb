class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      flash[:error] = 'Sorry, your credentials are bad'
      redirect_to user_login_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  def google
    @user = User.find_or_create_by(email: auth["info"]["email"]) do |user|
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.password = SecureRandom.hex(10)
      user.password_confirmation = user.password
    end

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error]= "Failed to authenticate with Google - #{@user.errors.full_messages}"
      redirect_to root_path
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
