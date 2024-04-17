require "rails_helper"

RSpec.describe DiscoverFacade do
  before(:each) do

  end

  describe "instance methods" do
    let(:search) {DiscoverFacade.new("Disneyland")}

    it "initializes with search parameters" do
      expect(search).to be_a DiscoverFacade
      expect(search.search_params).to eq("Disneyland")
    end

    it "can find locations of the search parameter", :vcr do
      locations = search.find_location
      expect(locations).to be_an(Array)
      locations.each do |location|
        expect(location.data).to be_a(Hash)
      end
    end

    it "can turn the search results into Search objects", :vcr do
      search_objects = search.search_objects

      expect(search_objects).to be_an(Array)

      search_objects.each do |object|
        expect(object).to be_a(Search)
      end
    end

    it "can turn search results into json data", :vcr do
      json_data = search.json_data

      expect(json_data).to be_a(String)
    end

    let(:paris) { DiscoverFacade.new("Paris")}
    it "can filter the created Search objects and select only unique display names", :vcr do
      expect(paris.search_objects.count).to eq(5)
      expect(paris.filtered_search_objects.count).to eq(3)
    end

    let(:big_air_chandler) { DiscoverFacade.new("Big Air Chandler")}
    it "checks if an array of objects is empty", :vcr do
      expect(big_air_chandler.empty?).to eq(true)
      expect(paris.empty?).to eq(false)
    end
  end
end
