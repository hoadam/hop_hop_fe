require 'rails_helper'

RSpec.describe 'Log in', type: :feature do
  describe 'When user visits log in page' do
    it 'shows a form to fill in, after the user clicks on "Login" the user is taken to their dashboard page' do
      user = User.create!(name: 'Selena', email: 'selena@gmail.com',
                           password: 'selena123', password_confirmation: 'selena123')
      visit new_user_session_path

      fill_in 'Email', with: 'selena@gmail.com'
      fill_in 'Password', with: 'selena123'
      click_on 'Log In'

      expect(current_path).to eq("/users/sign_in")
    end

    it 'user can sign in with Google' do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        provider: 'google',
        uid: '123456',
        info: {
          name: 'John Doe',
          email: 'test@example.com'
        }
      })

      visit new_user_session_path
      click_on "Log in with Google"

      expect(current_path).to eq("/")
    end

    it 'renders an error when invalid credentials' do #Sad Path
      user = User.create!(name: 'Selena', email: 'selena@gmail.com',
      password: 'selena123', password_confirmation: 'selena123')
      visit new_user_session_path

      fill_in 'Email', with: 'selena@wrong.com'
      fill_in 'Password', with: 'selena123'
      click_on 'Log in'
      expect(current_path).to eq(new_user_session_path)
      expect(page).to have_content("Invalid email or password")
    end
  end
end
