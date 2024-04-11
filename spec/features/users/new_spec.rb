require 'rails_helper'

RSpec.describe 'User Registration', type: :feature do
    it 'shows that user signed up successfully' do
        visit register_user_path

        fill_in 'Name', with: 'Selena'
        fill_in 'Email', with: 'selena@gmail.com'
        fill_in 'Password:', with: 'selena123'
        fill_in 'Password Confirmation:', with: 'selena123'
        
        click_button 'Create New User'

        expect(current_path).to eq(user_path(User.find_by(email: 'selena@gmail.com')))
    end

    it 'returns error message for wrong credentials' do #Sad path
        visit register_user_path

        fill_in 'Name', with: 'Selena'
        fill_in 'Email', with: ''
        fill_in 'Password:', with: 'selena123'
        fill_in 'Password Confirmation:', with: '123'
        
        click_button 'Create New User'

        expect(page).to have_content("Email can't be blank")
        expect(page).to have_content("Password confirmation doesn't match Password")
        expect(current_path).to eq(register_user_path)
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
    
      visit register_user_path
      click_on "Sign Up with Google"
    
      expect(current_path).to eq(user_path(User.first))
    end
end



