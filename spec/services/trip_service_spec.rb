require 'rails_helper'

describe TripService do
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
  describe '.conn' do
    it 'returns a Faraday connection' do
      expect(TripService.conn).to be_a(Faraday::Connection)
    end
  end

  describe '.get_url' do
    it 'makes a GET request to the specified URL' do
      expect(TripService).to receive(:conn).and_return(double(get: double(body: '{ "data": [] }')))
      TripService.get_url('test')
    end
  end

  describe '.get_trips' do
    it 'returns an array of Trip objects', :vcr do
      user_id = 100
      TripService.get_trips(user_id).each do |trip|
        TripService.delete_trip(user_id, trip.id)
      end

      trip_ids = 5.times.map do
        trip = TripService.create_trip(user_id, trip_params)
        trip.id
      end

      trips = TripService.get_trips(user_id)

      expect(trips.map(&:id)).to match_array(trip_ids)
      expect(trips.first).to be_a(Trip)
      expect(trips.first.name).not_to be_nil
    end
  end

  describe '.trip_details' do
    it 'returns a Trip object', :vcr do
      user_id = 200
      trip = TripService.create_trip(user_id, trip_params)

      trip = TripService.trip_details(user_id, trip.id)
      expect(trip).to be_a(Trip)
      expect(trip.name).not_to be_nil
    end
  end

  describe '.create_trip' do
    it 'creates a new trip', :vcr do
      user_id = 1
      response = TripService.create_trip(user_id, trip_params)

      expect(response.name).to eq('Trip To Japan')
      expect(response.location).to eq('Japan')
      expect(response.start_date).to eq(Date.parse '2024-04-20')
      expect(response.end_date).to eq(Date.parse '2024-04-30')
      expect(response.status).to eq('in_progress')
      expect(response.total_budget).to eq(1000)
    end
  end

  describe '.update_trip' do
    it 'updates an existing trip', :vcr do
      user_id = 1
      trip = TripService.create_trip(user_id, trip_params)
      trip_params = { name: 'Japan Trip' }

      response = TripService.update_trip(user_id, trip.id, trip_params)

      expect(response.id).to eq(trip.id)
      expect(response.name).to eq('Japan Trip')
    end
  end

  describe '.delete_trip' do
    it 'deletes an existing trip', :vcr do
      user_id = 1
      trip = TripService.create_trip(user_id, trip_params)

      response = TripService.delete_trip(user_id, trip.id)

      expect(response).to eq true
    end
  end
end
