require 'rails_helper'

RSpec.describe 'User Registration', type: :feature do
    it 'shows that user signed up successfully' do
        visit new_user_registration_path

        fill_in 'Name', with: 'Selena'
        fill_in 'Email', with: 'selena@gmail.com'
        fill_in 'user_password', with: 'selena123'
        fill_in 'user_password_confirmation', with: 'selena123'

        click_button 'Sign up'

        expect(current_path).to eq(root_path)
    end

    it 'returns error message for wrong credentials' do #Sad path
        visit new_user_registration_path

        fill_in 'Name', with: 'Selena'
        fill_in 'Email', with: ''
        fill_in 'user_password', with: 'selena123'
        fill_in 'user_password_confirmation', with: '123'

        click_button 'Sign up'

        expect(page).to have_content("Email can't be blank")
        expect(page).to have_content("Password confirmation doesn't match Password")
        expect(current_path).to eq(user_registration_path)
    end

    it "users can sign up using their google acocunt" do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        provider: 'google',
        uid: '123456',
        info: {
          name: 'John Doe',
          email: 'test@example.com'
        }
      })

      visit new_user_registration_path
      click_on "Log in with Google"

      expect(current_path).to eq(root_path)
    end
end
