class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show_otp, :verify_otp]

  def disable_otp
    if current_user.validate_and_consume_otp!(params[:otp_attempt])
      current_user.otp_required_for_login = false
      current_user.save!
      redirect_to root_path, notice: 'Two Factor Authentication disabled successfully.'
    else
      flash[:alert] = "Invalid OTP code."
      redirect_back(fallback_location: root_path)
    end
  def show
    @user = User.find(params[:id]).decorate
    @trips = TripService.get_trips(current_user.id)
  end

  def new
    @user = User.new
  end

  def show_otp
  end

  def verify_otp
    verifier = Rails.application.message_verifier(:otp_session)
    user_id = verifier.verify(session[:otp_token])
    user = User.find(user_id)

    if user.validate_and_consume_otp!(params[:otp_attempt])
      sign_in(:user, user)
      redirect_to root_path, notice: 'Logged in successfully'
    else
      flash[:alert] = "Invalid OTP code."
      redirect_to new_user_session_path
    end
  end

  def enable_otp_show_qr
    current_user.otp_secret = User.generate_otp_secret
    issuer = "Hop Hop!"
    label = "#{issuer}:#{current_user.email}"

    @provisioning_uri = current_user.otp_provisioning_uri(label, issuer:)
    current_user.save!
  end

  def enable_otp_verify
    if current_user.validate_and_consume_otp!(params[:otp_attempt])
      current_user.otp_required_for_login = true
      current_user.save!
      redirect_to edit_user_registration_path, notice: '2FA enabled successfully'
    else
      redirect_to enable_otp_show_qr_path, alert: 'Invalid OTP code.'
    end
  end
end
