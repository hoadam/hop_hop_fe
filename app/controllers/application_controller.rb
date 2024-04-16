class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_user

  private

  def current_user
    @_current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to user_login_path, :notice => "Not Authorized" if current_user.nil?
  end

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
