class SessionsController < ApplicationController
  def google
    @user = User.find_or_create_by(email: auth["info"]["email"]) do |user|
      user.username = auth["info"]["username"]
      user.password = SecureRandom.hex(10)
    end

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:error]= "Failed to authenticate with Google"
      redirect_to root_path
    end
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
