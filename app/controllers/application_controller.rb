class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :discover_facade

  def current_user
    @_current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  def discover_facade
    @discover_facade ||= DiscoverFacade.new(session[:search])
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
