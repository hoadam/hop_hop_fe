require "rails_helper"

RSpec.describe "Discover Index", type: :feature do
  before do
    @user = User.create!(name: 'Selena', email: 'selena@gmail.com',
      password: 'selena123', password_confirmation: 'selena123')

    visit new_user_session_path

    fill_in 'Email', with: 'selena@gmail.com'
    fill_in 'Password', with: 'selena123'
    click_on("Log in")

    visit new_trip_path
  end

  context "a user fills out all fields" do
    it "successfully creates a trip", :vcr do
      visit dashboard_path
      expect(page).to have_no_content("Girls Trip!")

      visit new_trip_path

      fill_in("Trip Name", with: "Girls Trip!")
      fill_in("Location", with: "Miami, Florida")
      select '2024', from: 'trip_start_date_1i' # Year
      select 'April', from: 'trip_start_date_2i' # Month
      select '17', from: 'trip_start_date_3i'    # Day
      select '2024', from: 'trip_end_date_1i' # Year
      select 'April', from: 'trip_end_date_2i' # Month
      select '20', from: 'trip_end_date_3i'    # Day
      fill_in("Total budget", with: "2000")

      click_on "Save Trip"
      expect(page.current_path).to eq(dashboard_path)
      expect(page).to have_content("Girls Trip!")

    end
  end

  context "a user leaves fields blank" do
    it "flashes a message and renders new", :vcr do
      click_on "Save Trip"

      expect(page).to have_content("Make sure you have filled out all fields correctly")

      fill_in("Trip Name", with: "Girls Trip!")
      fill_in("Location", with: "Girls Trip!")

      click_on "Save Trip"

      expect(page).to have_content("Make sure you have filled out all fields correctly")
    end
  end
end
