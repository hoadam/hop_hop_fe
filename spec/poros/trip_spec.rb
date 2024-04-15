require 'rails_helper'

RSpec.describe Trip do
  let(:id) { 1 }
  let(:name) { 'Trip Name' }
  let(:location) { 'Trip Location' }
  let(:start_date) { Date.new(2024, 1, 1).to_s }
  let(:end_date) { Date.new(2024, 1, 3).to_s }
  let(:status) { 'in_progress' }
  let(:total_budget) { 1000 }
  let(:total_expenses) { 500 }
  let(:daily_itineraries) { [] }

  let(:trip) { Trip.new(id, name, location, start_date, end_date, status, total_budget, total_expenses, daily_itineraries)}

  describe "#initialize" do
    it 'sets the attributes correctly' do
      expect(trip.id).to eq(id)
      expect(trip.name).to eq(name)
      expect(trip.location).to eq(location)
      expect(trip.start_date).to eq(start_date)
      expect(trip.end_date).to eq(end_date)
      expect(trip.status).to eq(status)
      expect(trip.total_budget).to eq(total_budget)
      expect(trip.total_expenses).to eq(total_expenses)
      expect(trip.daily_itineraries).to eq(daily_itineraries)
    end
  end

  describe '.from_json' do
    let(:json) do
      { data:
        {
          id: "1",
          attributes: {
            name: name,
            location: location,
            start_date: start_date,
            end_date: end_date,
            status: status,
            total_budget: total_budget,
            total_expenses: total_expenses,
            daily_itineraries: daily_itineraries
          }
        }
      }
    end

    it 'creates a Trip object from JSON' do
      trip = Trip.from_json(json)
      expect(trip.id).to eq("1")
      expect(trip.name).to eq(name)
      expect(trip.location).to eq(location)
      expect(trip.start_date).to eq(start_date)
      expect(trip.end_date).to eq(end_date)
      expect(trip.status).to eq(status)
      expect(trip.total_budget).to eq(total_budget)
      expect(trip.total_expenses).to eq(total_expenses)
      expect(trip.daily_itineraries).to eq(daily_itineraries)
    end
  end
end
