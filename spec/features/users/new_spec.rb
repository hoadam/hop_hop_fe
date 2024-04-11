require 'rails_helper'

RSpec.describe 'Sign Up', type: :feature do
  describe 'When user visits sign up page' do
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
end
