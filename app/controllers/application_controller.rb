class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  before_action :authenticate_user!

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
