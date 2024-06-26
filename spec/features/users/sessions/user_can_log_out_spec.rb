require 'rails_helper'

RSpec.describe 'User Logout', type: :feature do
  describe 'As a User' do
    before(:each) do
      user = User.create!(name: 'Selena',
                          email: 'selena@gmail.com',
                          password: 'selena123',
                          password_confirmation: 'selena123')

      visit new_user_session_path

      fill_in 'Email', with: 'selena@gmail.com'
      fill_in 'Password', with: 'selena123'
      click_on 'Log in'
    end

    it 'Can logout' do
      expect(current_path).to eq(root_path)
      expect(page).to have_link('Log Out')
      expect(page).to_not have_link('Log In')
      expect(page).to_not have_link('Sign up')

      click_on 'Log Out'

      expect(page).to have_content("Signed out successfully")
      expect(page).to have_link("Log In")
      expect(page).to have_link("Sign Up")
      expect(page).to_not have_link("Log Out")
    end
  end
end
