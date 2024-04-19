require 'rails_helper'

RSpec.describe Trip do
  let(:id) { 1 }
  let(:name) { 'Trip Name' }
  let(:location) { 'Trip Location' }
  let!(:start_date) { '2024-01-01' }
  let!(:end_date) { '2024-01-03' }
  let(:status) { 'in_progress' }
  let(:total_budget) { 1000 }
  let(:total_expenses) { 500 }
  let(:daily_itineraries) { [] }
  let(:activities) {[]}
  let(:lat) { 3.12345566}
  let(:lon) {-16.02000059}
  let(:trip) { Trip.new(id, name, location, lat, lon, start_date, end_date, status, total_budget, total_expenses, daily_itineraries, activities) }

  describe "#initialize" do
    it 'sets the attributes correctly' do
      expect(trip.id).to eq(id)
      expect(trip.name).to eq(name)
      expect(trip.location).to eq(location)
      expect(trip.start_date.to_s).to eq(start_date)  
      expect(trip.end_date.to_s).to eq(end_date)  
      expect(trip.status).to eq(status)
      expect(trip.total_budget).to eq(total_budget)
      expect(trip.total_expenses).to eq(total_expenses)
      expect(trip.daily_itineraries).to eq(daily_itineraries)
      expect(trip.activities).to eq(activities)
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
            daily_itineraries: daily_itineraries,
            activities: activities,
            lat: lat,
            lon: lon
          }
        }
      }
    end

    it 'creates a Trip object from JSON' do
      trip = Trip.from_json(json)
      expect(trip.id).to eq("1")
      expect(trip.name).to eq(name)
      expect(trip.location).to eq(location)
      expect(trip.start_date.to_s).to eq(start_date)  
      expect(trip.end_date.to_s).to eq(end_date)   
      expect(trip.status).to eq(status)
      expect(trip.total_budget).to eq(total_budget)
      expect(trip.total_expenses).to eq(total_expenses)
      expect(trip.daily_itineraries).to eq(daily_itineraries)
    end
  end

  describe '.from_json' do 
    let(:json) do
      {
        data: {
          id: "1",
          attributes: {
            name: name,
            location: location,
            start_date: start_date,
            end_date: end_date,
            status: status,
            total_budget: total_budget,
            total_expenses: total_expenses,
            daily_itineraries: {
              "2024-01-01" => [{
                data: {
                  id: "101",
                  type: "activity",
                  attributes: { name: "Hiking", description: "Hiking in the mountains" }
                }
              }]
            }
          }
        }
      }
    end

    it 'creates a Trip object from JSON and processes activities' do
      allow(Activity).to receive(:from_json).and_call_original
      trip = Trip.from_json(json)
      
      expect(Activity).to have_received(:from_json).with({
        id: "101",
        type: "activity",
        attributes: { name: "Hiking", description: "Hiking in the mountains" }
      })
      
      expect(trip.activities["2024-01-01"].length).to eq(1)
      expect(trip.activities["2024-01-01"].first).to be_an_instance_of(Activity)
      expect(trip.activities["2024-01-01"].first.name).to eq("Hiking")
    end
  end
end
