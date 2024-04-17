require "rails_helper"

RSpec.describe Search do
  let(:geocoder_data) { Geocoder.search("Disneyland")}

  it "takes in a Geocode object and filers it for necessary search data", :vcr do
    search_result = Search.new(geocoder_data.first)

    expect(search_result.display_name).to eq("Disneyland, 1313, South Harbor Boulevard, Anaheim Resort District, Anaheim, Orange County, California, 92802, United States")
    expect(search_result.lat).to eq("33.813651199999995")
    expect(search_result.lon).to eq("-117.91973507032726")
  end
end
