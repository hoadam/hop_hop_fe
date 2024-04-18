class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :authenticate_user!
  helper_method :discover_facade

  # Devise is now resposible for error messages
  # private

  # def error_message(errors)
  #   errors.full_messages.join(', ')
  # end
  def discover_facade
    @discover_facade ||= DiscoverFacade.new(session[:search])
  end

end
