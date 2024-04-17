require 'rails_helper'

RSpec.describe 'Edit User', type: :feature do
  describe 'As a user' do
    before(:each) do
      @user = User.create!(name: 'Selena', 
                          email: 'selena@gmail.com',
                          password: 'selena123',
                          password_confirmation: 'selena123')

      visit new_user_session_path

      fill_in 'Email', with: 'selena@gmail.com'
      fill_in 'Password', with: 'selena123'
      click_on 'Log in'

      expect(page).to have_button("Edit Profile")
      expect(page).to have_content("Logged in as #{@user.email}")

      click_on 'Edit Profile'

      expect(page).to have_content("Edit Profile")
    end

    it 'can edit its email' do
      expect(page).to have_field('user_email', with: "#{@user.email}")

      fill_in 'user_email', with: 'selena@test.com'
      fill_in 'user_current_password', with: "#{@user.password}"

      click_on 'Update'

      expect(page).to have_button("Edit Profile")
      expect(page).to have_content("Logged in as selena@test.com")
      expect(page).to_not have_content("Logged in as #{@user.email}")
    end

    it 'can edit its password' do
      expect(page).to have_field('user_email', with: "#{@user.email}")

      fill_in 'user_password', with: 'letmein'
      fill_in 'user_password_confirmation', with: 'letmein'
      fill_in 'user_current_password', with: "#{@user.password}"

      click_on 'Update'

      expect(page).to have_button("Edit Profile")
      expect(page).to have_button("Log Out")
      expect(page).to have_content("Logged in as #{@user.email}")
      
      click_on 'Log Out'

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Log in")

      click_on 'Log in'

      fill_in 'Email', with: 'selena@gmail.com'
      fill_in 'Password', with: 'selena123'

      click_on 'Log in'

      expect(page).to have_content("Invalid email or password")
      
      fill_in 'Email', with: 'selena@gmail.com'
      fill_in 'Password', with: 'letmein'

      click_on 'Log in'

      expect(page).to have_content("Signed in successfully")
      expect(page).to have_content("Logged in as #{@user.email}")
    end
  end
end