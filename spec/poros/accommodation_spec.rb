require 'rails_helper'

RSpec.describe Accommodation do
  describe '.from_json' do
    let(:json) do
      {
        id: 1,
        attributes: {
          name: "Accommodation name",
          address: "Accommodation address",
          lat: 123.456,
          lon: 456.789,
          type_of_accommodation: "Hotel",
          expenses: 100,
          check_in: "3:00 PM",
          check_out: "12:00 AM"
        }
      }
    end

    let(:accommodation) { Accommodation.from_json(json) }

    it 'creates an Accommodation object from JSON' do
      expect(accommodation.id).to eq(json[:id])
      expect(accommodation.name).to eq(json[:attributes][:name])
      expect(accommodation.address).to eq(json[:attributes][:address])
      expect(accommodation.lat).to eq(json[:attributes][:lat])
      expect(accommodation.lon).to eq(json[:attributes][:lon])
      expect(accommodation.type_of_accommodation).to eq(json[:attributes][:type_of_accommodation])
      expect(accommodation.expenses).to eq(json[:attributes][:expenses])
      expect(accommodation.check_in).to eq(json[:attributes][:check_in])
      expect(accommodation.check_out).to eq(json[:attributes][:check_out])
    end
  end
end
