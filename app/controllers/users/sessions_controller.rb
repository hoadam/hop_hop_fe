# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :authenticate_user!, only: [:after_sign_in_path_for]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # # # Adapted from Devise Sessions Controller
  def create
    self.resource = warden.authenticate!(auth_options.merge(strategy: :password_authenticable))

    if resource && resource.active_for_authentication?
      #If resource has 2FA enabled
      if resource.otp_required_for_login
        # generate a signed token for user ID.
        verifier = Rails.application.message_verifier(:otp_session)
        token = verifier.generate(resource.id)
        session[:otp_token] = token

        sign_out(resource_name)

        redirect_to user_otp_path and return
      else
        # 2FA is not required for login
        set_flash_message(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource) and return 
      end
    end

    #if user authentication fails
    flash[:alert] = "Invalid email or password."
    redirect_to new_user_session_path
  end

  # # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  
  def after_sign_in_path_for(resource_or_scope)
    root_path
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
