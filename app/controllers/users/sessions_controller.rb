class Users::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!, only: [:after_sign_in_path_for]
  
  # # # Adapted from Devise Sessions Controller
  def create
    self.resource = warden.authenticate!(auth_options.merge(strategy: :password_authenticable))

    if resource && resource.active_for_authentication?
      if resource.otp_required_for_login
        verifier = Rails.application.message_verifier(:otp_session)
        token = verifier.generate(resource.id)
        session[:otp_token] = token

        sign_out(resource_name)

        redirect_to user_otp_path and return
      else
        set_flash_message(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource) and return 
      end
    end
    flash[:alert] = "Invalid email or password."
    redirect_to new_user_session_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  
  def after_sign_in_path_for(resource_or_scope)
    root_path
  end
end
