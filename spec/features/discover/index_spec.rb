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
      # save_and_open_page
      input_field = find(:xpath, "/html/body/div/div/div[1]/div/gmp-place-autocomplete//div/div[1]/input", wait:10 )

        fill_in(:input, with: "Paris")
        click_on("Search")
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
      within "#search-Form" do
        click_on("Search")
      end

      expect(page).to have_no_css("#results")
      expect(page).to have_content("Sorry, enter a search")
    end
  end

  context "a user searches for a new search" do
    it "repopulates with a different result", :vcr do
      within "#search-Form" do
        fill_in("search[search]", with: "Paris")
        click_on("Search")
      end

      within "#results" do
        link_1 = find("a[href='/discover.5?lat=48.8263025&lon=2.382592'][data-turbo-method='get']")
        expect(link_1).to have_text("Appel Médical Search, Place Keith-Haring, Quartier de la Gare, 13th Arrondissement, Paris, Ile-de-France, Metropolitan France, 75013, France")

        link_2 = find("a[href='/discover.5?lat=48.8360731&lon=2.3876656'][data-turbo-method='get']")
        expect(link_2).to have_text("Randstad Search, Rue Lachambeaudie, Quartier de Bercy, 12th Arrondissement, Paris, Ile-de-France, Metropolitan France, 75012, France")

        link_2 = find("a[href='/discover.5?lat=48.8718433&lon=2.2981454'][data-turbo-method='get']")
        expect(link_2).to have_text("Appel Médical Search, Rue Vernet, Quartier des Champs-Élysées, 8th Arrondissement of Paris, Paris, Ile-de-France, Metropolitan France, 75008, France")

        link_2 = find("a[href='/discover.5?lat=48.8718646&lon=2.298059'][data-turbo-method='get']")
        expect(link_2).to have_text("Expectra Search, Rue Vernet, Quartier des Champs-Élysées, 8th Arrondissement of Paris, Paris, Ile-de-France, Metropolitan France, 75008, France")
      end
    end
  end
end
