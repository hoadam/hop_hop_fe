require 'rails_helper'
require 'rqrcode'

RSpec.describe "Two-Factor Authentication", type: :feature do
  before do
    @user = create(:user)
  end

  describe "Enabling 2FA" do
    it "allows user to enable 2FA" do
      allow_any_instance_of(User).to receive(:validate_and_consume_otp!).and_return(true)

      # Sign in the user
      login_as @user

      # Navigate to the page for enabling two-factor authentication
      visit enable_otp_show_qr_path

      # Stub the QR code generation to return a known URI
      allow_any_instance_of(User).to receive(:otp_provisioning_uri).and_return("example_uri")

      # Ensure the page contains the QR code
      expect(page).to have_css('svg')

      # Enter any OTP code and submit the form
      fill_in "Enter OTP", with: "any_otp_code"
      click_button "Verify and Enable"

      # Ensure two-factor authentication is enabled for the user
      @user.reload
      expect(@user.otp_required_for_login).to be_truthy

      # Ensure user is redirected to the correct page with a success message
      expect(current_path).to eq(edit_user_registration_path)
      expect(page).to have_content("2FA enabled successfully")        
    end

    it "allows user to enable 2FA only if they use the correct OTP code" do
      # Sign in the user
      login_as @user

      # Navigate to the page for enabling two-factor authentication
      visit enable_otp_show_qr_path

      # Stub the QR code generation to return a known URI
      allow_any_instance_of(User).to receive(:otp_provisioning_uri).and_return("example_uri")

      # Ensure the page contains the QR code
      expect(page).to have_css('svg')

      # Enter any OTP code and submit the form
      fill_in "Enter OTP", with: "any_otp_code"
      click_button "Verify and Enable"

      # Ensure two-factor authentication is enabled for the user
      @user.reload
      expect(@user.otp_required_for_login).to be_falsey

      # Ensure user is redirected to the correct page with a success message
      expect(current_path).to eq(enable_otp_show_qr_path)
      expect(page).to have_content("Invalid OTP code.")
    end
  end

  describe "Disabling 2FA" do
    it "allows user to disable 2FA" do
      user = create(:user, otp_required_for_login: true)
      
      allow_any_instance_of(User).to receive(:validate_and_consume_otp!).and_return(true)
      
      login_as(user)
      
      visit edit_user_registration_path
      # save_and_open_page

      fill_in "user_otp_attempt", with: "any_otp_code"
      fill_in "user_current_password", with: user.password

      click_button "Update"

      expect(page).to have_content("Your account has been updated successfully")
    end

    it 'expects user to input current password' do
      user = create(:user, otp_required_for_login: true)

      allow_any_instance_of(User).to receive(:validate_and_consume_otp!).and_return(true)

      login_as(user)

      visit edit_user_registration_path

      fill_in "user_otp_attempt", with: "any_otp_code"

      click_button "Update"

      expect(page).to have_content("Current password can't be blank")
    end

    it 'expects user to input correct current password' do
      user = create(:user, otp_required_for_login: true)

      allow_any_instance_of(User).to receive(:validate_and_consume_otp!).and_return(true)

      login_as(user)

      visit edit_user_registration_path

      fill_in "user_otp_attempt", with: "any_otp_code"
      fill_in "user_current_password", with: "any_password"

      click_button "Update"

      expect(page).to have_content("Invalid Password")
    end

    it 'expects user to input correct OTP and current password' do
      user = create(:user, otp_required_for_login: true)

      login_as(user)

      visit edit_user_registration_path

      fill_in "user_otp_attempt", with: "any_otp_code"
      fill_in "user_current_password", with: "any_password"

      click_button "Update"

      expect(page).to have_content("Invalid OTP code")
    end
  end

  describe "Verifying OTP during login" do
    it "allows user to login with OTP" do
      user = create(:user, otp_required_for_login: true)

      allow_any_instance_of(User).to receive(:validate_and_consume_otp!).and_return(true)

      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"

      expect(page).to have_content("Enter OTP")

      fill_in "OTP Code", with: "123456" 

      click_button "Verify"

      expect(page).to have_content("Logged in successfully")
    end
  end

  describe "Verifying OTP during login" do
    it "does not allows user to login with ANY OTP" do
      user = create(:user, otp_required_for_login: true)

      visit new_user_session_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"

      expect(page).to have_content("Enter OTP")

      fill_in "OTP Code", with: "123456" 

      click_button "Verify"

      expect(page).to have_content("Invalid OTP code")
    end
  end
end
