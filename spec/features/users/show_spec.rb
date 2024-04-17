require 'rails_helper'

RSpec.feature "UserProfile", type: :feature do
  let!(:user) { create(:user, email: 'user@gmail.com', password: 'password123') }
  let!(:past_trip) { create(:trip, user: user, name: 'Past Trip', start_date: 2.weeks.ago, end_date: 1.week.ago) }
  let!(:current_trip) { create(:trip, user: user, name: 'Current Trip', start_date: Date.today, end_date: 1.week.from_now) }

  it "User logs in and views their profile" do
    # User logs in
    visit user_login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password123'
    click_button 'Login'

    # visit user_path(user)

    # expect(page).to have_content(user.name)
    # expect(page).to have_content(user.email)

    # expect(page).to have_content('Past Trips')
    # expect(page).to have_content('Past Trip')
    # expect(page).to have_content(past_trip.start_date.strftime('%Y-%m-%d'))
    # expect(page).to have_content(past_trip.end_date.strftime('%Y-%m-%d'))
    # expect(page).to have_link('Edit')
    # expect(page).to have_button('Delete')

    # expect(page).to have_content('Current Trips')
    # expect(page).to have_content('Current Trip')
    # expect(page).to have_content(current_trip.start_date.strftime('%Y-%m-%d'))
    # expect(page).to have_content(current_trip.end_date.strftime('%Y-%m-%d'))
    # expect(page).to have_link('Edit')
    # expect(page).to have_button('Delete')

    # expect(page).to have_button('Logout')
  end

#   it "User logs out" do
#     login_as(user, scope: :user)
#     visit user_path(user)

#     click_button 'Logout'

#     expect(current_path).to eq(root_path)
#     expect(page).to have_content('Login')
#   end
end
