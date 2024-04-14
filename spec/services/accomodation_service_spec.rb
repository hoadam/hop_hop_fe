require 'rails_helper'

RSpec.describe AccommodationService do
  let(:accommodation_params) do
    {
      name: 'Conrad Tokyo',
      address: 'Ginza, Tokyo',
      check_in: '2024-04-20',
      check_out: '2024-04-30'
    }
  end

  let(:trip_params) do
    {
      name: 'Trip To Japan',
      location: 'Japan',
      start_date: '2024-04-20',
      end_date: '2024-04-30',
      status: 'in_progress',
      total_budget: 1000
    }
  end
  describe '.get_accommodations' do
    it 'returns an array of Accommodation objects', :vcr do
      user_id = 1
      trip = TripService.create_trip(user_id, trip_params)

      accommodation_ids = 5.times.map do
        accommodation = AccommodationService.create_accommodation(user_id, trip.id, accommodation_params)
        accommodation.id
      end

      accommodations = AccommodationService.get_accommodations(user_id, trip.id)

      expect(accommodations.map(&:id)).to match_array(accommodation_ids)
      expect(accommodations.first).to be_an(Accommodation)
      expect(accommodations.first.name).not_to be_nil
    end
  end

  describe '.accommodation_details' do
    it 'returns an Accommodation object', :vcr do
      user_id = 1
      trip = TripService.create_trip(user_id, trip_params)
      accommodation = AccommodationService.create_accommodation(user_id, trip.id, accommodation_params)

      accommodation = AccommodationService.accommodation_details(user_id, trip.id, accommodation.id)

      expect(accommodation).to be_a(Accommodation)
      expect(accommodation.name).not_to be_nil
    end
  end

  describe '.create_accommodation' do
    it 'creates a new accommodation', :vcr do
      user_id = 1
      trip = TripService.create_trip(user_id, trip_params)

      response = AccommodationService.create_accommodation(user_id, trip.id, accommodation_params)

      expect(response.name).to eq('Conrad Tokyo')
      expect(response.address).to eq('Ginza, Tokyo')
    end
  end

  describe '.update_accommodation' do
    it 'updates an existing accommodation', :vcr do
      user_id = 1
      trip = TripService.create_trip(user_id, trip_params)
      accommodation = AccommodationService.create_accommodation(user_id, trip.id, accommodation_params)
      update_params = { name: 'Cerulean Hotel' }

      response = AccommodationService.update_accommodation(user_id, trip.id, accommodation.id, update_params)

      expect(response.id).to eq(accommodation.id)
      expect(response.name).to eq('Cerulean Hotel')
    end
  end

  describe '.delete_accommodation' do
    it 'deletes an existing accommodation', :vcr do
      user_id = 1
      trip = TripService.create_trip(user_id, trip_params)
      accommodation = AccommodationService.create_accommodation(user_id, trip.id, accommodation_params)

      response = AccommodationService.delete_accommodation(user_id, trip.id, accommodation.id)

      expect(response).to eq(true)
    end
  end
end
