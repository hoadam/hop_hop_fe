require 'rails_helper'
require 'rqrcode'

RSpec.describe "Two-Factor Authentication", type: :feature do
  before do
    @user = User.create!(name: 'Selena', 
                          email: 'selena@gmail.com',
                          password: 'selena123',
                          password_confirmation: 'selena123')

    allow(RQRCode::QRCode).to receive(:new).and_return(double('qr_code', as_svg: 'stubbed_svg'))
  end

  describe "Enabling 2FA" do
    it "allows user to enable 2FA" do
      login_as(@user)
      visit edit_user_registration_path
      click_link "Enable 2FA"
      
      expect(page).to have_css("div", text: "stubbed_svg")

      fill_in "Enter OTP", with: "123456"

      click_button "Verify and Enable"

      expect(page).to have_content("2FA enabled successfully")
    end
  end

  describe "Disabling 2FA" do
    it "allows user to disable 2FA" do
      @user.enable_otp!
      login_as(@user)
      visit edit_user_registration_path
      fill_in "OTP Code", with: "123456" # Replace with your OTP
      click_button "Verify"
      expect(page).to have_content("Two Factor Authentication disabled successfully")
    end
  end

  describe "Verifying OTP during login" do
    it "allows user to login with OTP" do
      @user.enable_otp!
      visit new_user_session_path
      fill_in "Email", with: @user.email
      fill_in "Password", with: @user.password
      click_button "Log in"
      expect(page).to have_content("Enter OTP")
      fill_in "OTP Code", with: "123456" # Replace with your OTP
      click_button "Verify"
      expect(page).to have_content("Logged in successfully")
    end
  end
end
