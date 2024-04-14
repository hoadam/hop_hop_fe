require 'rails_helper'

RSpec.describe Activity do
  describe Activity do
    let(:id) { 1 }
    let(:name) { 'Activity Name' }
    let(:address) { 'Activity Address' }
    let(:lat) { 123.456 }
    let(:lon) { 789.012 }
    let(:rating) { 4.5 }
    let(:time) { '10:00 AM' }
    let(:expenses) { 50 }
    let(:description) { 'Activity Description' }

    let(:activity) { Activity.new(id, name, address, lat, lon, rating, time, expenses, description) }

    describe '#initialize' do
      it 'sets the attributes correctly' do
        expect(activity.id).to eq(id)
        expect(activity.name).to eq(name)
        expect(activity.address).to eq(address)
        expect(activity.lat).to eq(lat)
        expect(activity.lon).to eq(lon)
        expect(activity.rating).to eq(rating)
        expect(activity.time).to eq(time)
        expect(activity.expenses).to eq(expenses)
        expect(activity.description).to eq(description)
      end
    end

    describe '.from_json' do
      let(:json) do
        {
          id: id,
          attributes: {
            name: name,
            address: address,
            lat: lat,
            lon: lon,
            rating: rating,
            time: time,
            expenses: expenses,
            description: description
          }
        }
      end

      it 'creates an Activity object from JSON' do
        activity = Activity.from_json(json)
        expect(activity.id).to eq(id)
        expect(activity.name).to eq(name)
        expect(activity.address).to eq(address)
        expect(activity.lat).to eq(lat)
        expect(activity.lon).to eq(lon)
        expect(activity.rating).to eq(rating)
        expect(activity.time).to eq(time)
        expect(activity.expenses).to eq(expenses)
        expect(activity.description).to eq(description)
      end
    end
  end
end
