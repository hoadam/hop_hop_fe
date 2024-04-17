require 'rails_helper'

RSpec.describe DailyItinerary do
  describe '.from_json' do
    let(:json) do
      {
        id: "1",
        attributes: {
          trip_id: 2,
          date: "2024-02-14"
        }
      }
    end

    it 'creates a Trip object from JSON' do
      daily_itinerary = DailyItinerary.from_json(json)
      expect(daily_itinerary.id).to eq("1")
      expect(daily_itinerary.trip_id).to eq(2)
      expect(daily_itinerary.date).to eq("2024-02-14")
    end
  end
end
