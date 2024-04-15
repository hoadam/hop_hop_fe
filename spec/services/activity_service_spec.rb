# require 'rails_helper'

# describe ActivityService do
#   let(:activity_params) do
#     {
#       name: 'Teamlab Planet'
#     }
#   end
#   let(:user_id) { 1 }
#   let(:trip_params) {{name: 'Trip To Japan', location: 'Japan', start_date: '2024-04-20', end_date: '2024-04-30', status: 'in_progress', total_budget: 1000}}
#   let!(:trip) { TripService.create_trip(user_id, trip_params) }
#   let!(:daily_itinerary) {}

#   describe '.conn' do
#     it 'returns a Faraday connection' do
#       expect(ActivityService.conn).to be_a(Faraday::Connection)
#     end
#   end

#   describe '.get_url' do
#     it 'makes a GET request to the specified URL' do
#       allow(ActivityService).to receive(:conn).and_return(double(get: double(body: '{ "data": [] }')))
#       ActivityService.get_url('test')
#     end
#   end

#   describe '.daily_activities' do
#     it 'returns an array of Activity objects in a day', :vcr do
#       user_id = 20
#       trip_id = 5
#       daily_itinerary_id = 1

#       activity_ids = 5.times.map do
#         activity = ActivityService.create_activity(user_id, trip_id, daily_itinerary_id, activity_params)
#         activity.id
#       end

#       activities = ActivityService.daily_activities(user_id, trip_id, daily_itinerary_id)
#       expect(activities.map(&:id)).to match_array(activity_ids)
#       expect(activities.first.name).not_to be_nil
#     end
#   end

#   describe '.activity_details' do
#     it 'returns a single Activity object', :vcr do
#       user_id = 25
#       trip_id = 10
#       daily_itinerary_id = 2

#       activity = Activity.create_activity(user_id, trip_id, daily_itinerary_id, activity_params)

#       activity = ActivityService.activity_details(user_id, trip_id, daily_itinerary_id, activity.id)

#       expect(activity).to be_a(Activity)
#       expect(activity.name).not_to be_nil
#     end
#   end

#   describe '.create_activity' do
#     it 'creates a new activity', :vcr do
#       user_id = 142
#       trip_id = 16
#       daily_itinerary_id = 3

#       response = ActivityService.create_activity(user_id, trip_id, daily_itinerary_id, activity_params)

#       expect(response.name).to eq('Teamlab Planet')
#     end
#   end

#   describe '.update_activity' do
#     it 'updates an existing activity', :vcr do
#       user_id = 123
#       trip_id = 27
#       daily_itinerary_id = 4
#       activity = ActivityService.create_activity(user_id, trip_id, daily_itinerary_id, activity_params)
#       update_activity_params = { name: 'Shibuya Crossing' }
#       response = ActivityService.update_activity(user_id, trip_id, daily_itinerary_id, activity.id, update_activity_params)

#       expect(response.name).to eq('Shibuya Crossing')
#     end
#   end

#   describe '.delete_trip' do
#       it 'deletes an existing activity', :vcr do
#         user_id = 75
#         trip_id = 19
#         daily_itinerary_id = 5
#         activity = ActivityService.create_activity(user_id, trip_id, daily_itinerary_id, activity_params)

#         response = ActivityService.delete_activity(user_id, trip_id, daily_itinerary_id, activity.id)

#         expect(response).to eq(true)
#     end
#   end
# end
