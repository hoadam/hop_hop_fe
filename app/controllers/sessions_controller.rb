class SessionsController < Devise::SessionsController
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
    session[:user_id] = nil
    redirect_to root_path
  end

  
end
