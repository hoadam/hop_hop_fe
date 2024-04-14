# require 'rails_helper'

# RSpec.describe AccommodationService do
#   let(:user_id) { 1 }
#   let(:trip_id) { 1 }
#   let(:accommodation_id) { 1 }
#   let(:accommodation_params) { { name: "Updated Accommodation name" } }

#   describe '.conn' do
#     it 'returns a Faraday connection' do
#       expect(AccommodationService.conn).to be_a(Faraday::Connection)
#     end
#   end

#   describe '.get_url' do
#     it 'makes a GET request to the specified URL' do
#       allow(AccommodationService).to receive(:conn).and_return(double(get: double(body: { "data": [] }.to_json)))
#       AccommodationService.get_url('test')
#     end
#   end

#   describe '.get_accommodations' do
#     it 'returns a list of accommodations' do
#       allow(AccommodationService).to receive(:conn).and_return(double(get: double(body: { "data": [{ id: 1, attributes: { name: "Hotel Name" } }] }.to_json)))

#       accommodations = AccommodationService.get_accommodations(1, 1)

#       expect(accommodations).to be_an(Array)
#       expect(accommodations.size).to eq(1)
#       expect(accommodations.first.name).to eq('Hotel Name')
#     end
#   end

#   describe '.accommodation_details' do
#     it 'returns an accommodation object' do
#       allow(AccommodationService).to receive(:conn).and_return(double(get: double(body: { id: 1, attributes: { name: "Hotel Name" } }.to_json)))

#       accommodation = AccommodationService.accommodation_details(user_id, trip_id, accommodation_id)

#       expect(accommodation.name).to eq('Hotel Name')
#       expect(accommodation).to be_a(Accommodation)
#     end
#   end

#   describe '.create_accommodation' do
#     it 'creates a new accommodation' do
#       allow(AccommodationService).to receive(:conn).and_return(double(post: double(body: { id: 1, name: "New Hotel Name" }.to_json)))

#       response = AccommodationService.create_accommodation(user_id, trip_id, { name: "New Hotel Name" })

#       expect(response[:name]).to eq('New Hotel Name')
#       expect(response[:id]).to eq(1)
#     end
#   end

#   describe '.update_accommodation' do
#     it 'updates an existing accommodation' do
#       allow(AccommodationService).to receive(:conn).and_return(double(put: double(body: { id: 1, attribute: { name: "Updated Accommodation Name" } }.to_json)))

#       response = AccommodationService.update_accommodation(user_id, trip_id, accommodation_id, accommodation_params)

#       expect(response[:id]).to eq(1)
#       expect(response[:name]).to eq('Updated Accommodation Name')
#     end
#   end

#   describe '.delete_accommodation' do
#     it 'deletes an existing accommodation' do
#       allow(AccommodationService).to receive(:conn).and_return(double(delete: nil))

#       response = AccommodationService.delete_accommodation(user_id, trip_id, accommodation_id)

#       expect(response).to be_nil
#     end
#   end
# end
