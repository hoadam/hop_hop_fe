require "rails_helper"

RSpec.describe "Discover Index", type: :feature do
  before do
    @user = User.create!(name: 'Selena', email: 'selena@gmail.com',
      password: 'selena123', password_confirmation: 'selena123')
    visit user_login_path

    fill_in 'Email', with: 'selena@gmail.com'
    fill_in 'Password', with: 'selena123'
    click_button 'Log In'

    visit user_discover_index_path(@user.id)
  end

  context "a user searches for a location" do
    it "displays the results with clickable links", :vcr do
      expect(page).to have_no_css("#results")

      within "#search-form" do
        fill_in(:search, with: "Paris")
        click_button("Search")
      end
      expect(page).to have_css("#results")

      within "#results" do
        expect(page).to have_link("Paris, Ile-de-France, Metropolitan France, France")
        expect(page).to have_link("Paris, Lamar County, Texas, United States")
        expect(page).to have_link("Town of Paris, Oneida County, New York, United States")
      end
    end
  end

  context "a user navigates away from the page" do
    it "keeps track of the results when clicking on other links", :vcr do
      within "#search-form" do
        fill_in(:search, with: "Paris")
        click_button("Search")
      end

      click_link("Paris, Ile-de-France, Metropolitan France, France")
      expect(page.current_path).to eq(user_discover_index_path(@user))

      within "#results" do
        expect(page).to have_link("Paris, Ile-de-France, Metropolitan France, France")
        expect(page).to have_link("Paris, Lamar County, Texas, United States")
        expect(page).to have_link("Town of Paris, Oneida County, New York, United States")
      end
    end

    it "keeps track of results when navigating away from the page", :vcr do
      within "#search-form" do
        fill_in(:search, with: "Paris")
        click_button("Search")
      end

      click_link("Dashboard")
      expect(page.current_path).to eq(user_path(@user))

      click_link("Discover")
      expect(page.current_path).to eq(user_discover_index_path(@user))

      within "#results" do
        expect(page).to have_link("Paris, Ile-de-France, Metropolitan France, France")
        expect(page).to have_link("Paris, Lamar County, Texas, United States")
        expect(page).to have_link("Town of Paris, Oneida County, New York, United States")
      end
    end
  end

  context "a user searches for a new search" do
    it "repopulates with a different result", :vcr do
      within "#search-form" do
        fill_in(:search, with: "Paris")
        click_button("Search")
      end

      within "#results" do
        expect(page).to have_link("Paris, Ile-de-France, Metropolitan France, France")
        expect(page).to have_link("Paris, Lamar County, Texas, United States")
        expect(page).to have_link("Town of Paris, Oneida County, New York, United States")
      end

      within "#search-form" do
        fill_in(:search, with: "Disneyland")
        click_button("Search")
      end

      within "#results" do
        expect(page).to have_link("Disneyland, 1313, South Harbor Boulevard, Anaheim Resort District, Anaheim, Orange County, California, 92802, United States")
        expect(page).to have_link("Disneyland, Area D (Elaho/Garibaldi), Squamish-Lillooet Regional District, British Columbia, V0N 1J0, Canada")
        expect(page).to have_link("Disneyland, Waterbury, Washington County, Vermont, 05671, United States")
      end
    end
  end
end
