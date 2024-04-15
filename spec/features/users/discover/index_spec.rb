require 'rails_helper'

RSpec.describe 'discover page', type: :feature do
  describe 'as a logged user' do
    before(:each) do
      @user = User.create!(name: 'Selena', email: 'selena@gmail.com',
      password: 'selena123', password_confirmation: 'selena123')
      visit user_login_path

      fill_in 'Email', with: 'selena@gmail.com'
      fill_in 'Password', with: 'selena123'
      click_button 'Log In'
    end

    it 'has a link on the user dashboard' do
      expect(page).to have_content ("Discover")

      click_on "Discover"

      expect(current_path).to eq(user_discover_path(@user))
      expect(page).to have_content("Discover")
      expect(page).to have_content("Search for a place to discover:")
    end
  end
end
