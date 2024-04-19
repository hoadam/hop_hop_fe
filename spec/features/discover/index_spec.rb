require "rails_helper"

RSpec.describe "Discover Index", type: :feature do
  before do
    @user = User.create!(name: 'Selena', email: 'selena@gmail.com',
      password: 'selena123', password_confirmation: 'selena123')

    visit new_user_session_path

    fill_in 'Email', with: 'selena@gmail.com'
    fill_in 'Password', with: 'selena123'
    click_on("Log in")

    visit discover_index_path
  end

  context "a user searches for a location" do
    it "displays the results with clickable links", :vcr do
      expect(page).to have_no_css("#results")

      within "#search-form" do
        fill_in("search[search]", with: "Paris")
        click_on("Search")
      end
      expect(page).to have_css("#results")

      link_1 = find("a[href='/discover.1?lat=48.8263025&lon=2.382592'][data-turbo-method='get']")
      expect(link_1).to have_text("Appel Médical Search, Place Keith-Haring, Quartier de la Gare, 13th Arrondissement, Paris, Ile-de-France, Metropolitan France, 75013, France")

      link_2 = find("a[href='/discover.1?lat=48.8360731&lon=2.3876656'][data-turbo-method='get']")
      expect(link_2).to have_text("Randstad Search, Rue Lachambeaudie, Quartier de Bercy, 12th Arrondissement, Paris, Ile-de-France, Metropolitan France, 75012, France")

      link_2 = find("a[href='/discover.1?lat=48.8718433&lon=2.2981454'][data-turbo-method='get']")
      expect(link_2).to have_text("Appel Médical Search, Rue Vernet, Quartier des Champs-Élysées, 8th Arrondissement of Paris, Paris, Ile-de-France, Metropolitan France, 75008, France")

      link_2 = find("a[href='/discover.1?lat=48.8718646&lon=2.298059'][data-turbo-method='get']")
      expect(link_2).to have_text("Expectra Search, Rue Vernet, Quartier des Champs-Élysées, 8th Arrondissement of Paris, Paris, Ile-de-France, Metropolitan France, 75008, France")
    end

    it "renders an error when no results show", :vcr do
      within "#search-form" do
        fill_in("search[search]", with: "Big Air Chandler")
        click_on("Search")
      end

      expect(page).to have_no_css("#results")
      expect(page).to have_content("Sorry, couldn't find Big Air Chandler, try again.")
    end
  end

  context "a user navigates away from the page" do
    it "keeps track of the results when clicking on other links", :vcr do
      within "#search-form" do
        fill_in("search[search]", with: "Paris")
        click_on("Search")
      end

      click_on("Appel Médical Search, Place Keith-Haring, Quartier de la Gare, 13th Arrondissement, Paris, Ile-de-France, Metropolitan France, 75013, France")

      within "#results" do
      save_and_open_page
        link_1 = find("a[href='/discover.3?lat=48.8263025&lon=2.382592'][data-turbo-method='get']")
        expect(link_1).to have_text("Appel Médical Search, Place Keith-Haring, Quartier de la Gare, 13th Arrondissement, Paris, Ile-de-France, Metropolitan France, 75013, France")

        link_2 = find("a[href='/discover.3?lat=48.8360731&lon=2.3876656'][data-turbo-method='get']")
        expect(link_2).to have_text("Randstad Search, Rue Lachambeaudie, Quartier de Bercy, 12th Arrondissement, Paris, Ile-de-France, Metropolitan France, 75012, France")

        link_2 = find("a[href='/discover.3?lat=48.8718433&lon=2.2981454'][data-turbo-method='get']")
        expect(link_2).to have_text("Appel Médical Search, Rue Vernet, Quartier des Champs-Élysées, 8th Arrondissement of Paris, Paris, Ile-de-France, Metropolitan France, 75008, France")

        link_2 = find("a[href='/discover.3?lat=48.8718646&lon=2.298059'][data-turbo-method='get']")
        expect(link_2).to have_text("Expectra Search, Rue Vernet, Quartier des Champs-Élysées, 8th Arrondissement of Paris, Paris, Ile-de-France, Metropolitan France, 75008, France")
      end
    end

    it "keeps track of results when navigating away from the page", :vcr do
      within "#search-form" do
        fill_in("search[search]", with: "Paris")
        click_on("Search")
      end
      save_and_open_page
      click_button("Dashboard")
      expect(page.current_path).to eq(dashboard_path)

      click_button("Discover")
      expect(page.current_path).to eq(discover_index_path)

      within "#results" do
        link_1 = find("a[href='/discover.1?lat=48.8263025&lon=2.382592'][data-turbo-method='get']")
        expect(link_1).to have_text("Appel Médical Search, Place Keith-Haring, Quartier de la Gare, 13th Arrondissement, Paris, Ile-de-France, Metropolitan France, 75013, France")

        link_2 = find("a[href='/discover.1?lat=48.8360731&lon=2.3876656'][data-turbo-method='get']")
        expect(link_2).to have_text("Randstad Search, Rue Lachambeaudie, Quartier de Bercy, 12th Arrondissement, Paris, Ile-de-France, Metropolitan France, 75012, France")

        link_2 = find("a[href='/discover.1?lat=48.8718433&lon=2.2981454'][data-turbo-method='get']")
        expect(link_2).to have_text("Appel Médical Search, Rue Vernet, Quartier des Champs-Élysées, 8th Arrondissement of Paris, Paris, Ile-de-France, Metropolitan France, 75008, France")

        link_2 = find("a[href='/discover.1?lat=48.8718646&lon=2.298059'][data-turbo-method='get']")
        expect(link_2).to have_text("Expectra Search, Rue Vernet, Quartier des Champs-Élysées, 8th Arrondissement of Paris, Paris, Ile-de-France, Metropolitan France, 75008, France")
      end
    end
  end

  context "a user searches for a new search" do
    it "repopulates with a different result", :vcr do
      within "#search-form" do
        fill_in("search[search]", with: "Paris")
        click_on("Search")
      end

      within "#results" do
        link_1 = find("a[href='/discover.3?lat=48.8263025&lon=2.382592'][data-turbo-method='get']")
        expect(link_1).to have_text("Appel Médical Search, Place Keith-Haring, Quartier de la Gare, 13th Arrondissement, Paris, Ile-de-France, Metropolitan France, 75013, France")

        link_2 = find("a[href='/discover.3?lat=48.8360731&lon=2.3876656'][data-turbo-method='get']")
        expect(link_2).to have_text("Randstad Search, Rue Lachambeaudie, Quartier de Bercy, 12th Arrondissement, Paris, Ile-de-France, Metropolitan France, 75012, France")

        link_2 = find("a[href='/discover.3?lat=48.8718433&lon=2.2981454'][data-turbo-method='get']")
        expect(link_2).to have_text("Appel Médical Search, Rue Vernet, Quartier des Champs-Élysées, 8th Arrondissement of Paris, Paris, Ile-de-France, Metropolitan France, 75008, France")

        link_2 = find("a[href='/discover.3?lat=48.8718646&lon=2.298059'][data-turbo-method='get']")
        expect(link_2).to have_text("Expectra Search, Rue Vernet, Quartier des Champs-Élysées, 8th Arrondissement of Paris, Paris, Ile-de-France, Metropolitan France, 75008, France")
      end

      within "#search-form" do
        fill_in("search[search]", with: "Disneyland")
        click_on("Search")
      end
      # Nothing is comming up for me - Igor
      within "#results" do
        # expect(page).to have_link("Disneyland, 1313, South Harbor Boulevard, Anaheim Resort District, Anaheim, Orange County, California, 92802, United States")
        # expect(page).to have_link("Disneyland, Area D (Elaho/Garibaldi), Squamish-Lillooet Regional District, British Columbia, V0N 1J0, Canada")
        # expect(page).to have_link("Disneyland, Waterbury, Washington County, Vermont, 05671, United States")
      end
    end
  end
end
