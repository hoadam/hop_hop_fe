class ActivityService < HophopService
  def self.daily_activities(user_id, trip_id, daily_itinerary_id)
    response = get_url("trips/#{trip_id}/daily_itineraries/#{daily_itinerary_id}/activities", user_id: user_id)
    response[:data].map do |json|
      Activity.from_json(json)
    end
  end

  def self.activity_details(user_id, trip_id, daily_itinerary_id, activity_id)
    response = get_url("trips/#{trip_id}/daily_itineraries/#{daily_itinerary_id}/activities/#{activity_id}", user_id: user_id)

    Activity.from_json(response[:data])
  end

  def self.create_activity(user_id, trip_id, daily_itinerary_id, activity_params)
    response = conn.post("trips/#{trip_id}/daily_itineraries/#{daily_itinerary_id}/activities") do |req|
      req.body = {
        activity: activity_params.merge(user_id: user_id)
  }.to_json
    end

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    Activity.from_json(json)
  end

  def self.update_activity(user_id, trip_id, daily_itinerary_id, activity_id, activity_params)
    response = conn.put("trips/#{trip_id}/daily_itineraries/#{daily_itinerary_id}/activities/#{activity_id}") do |req|
      req.body = {
        activity: activity_params.merge(user_id: user_id)
      }.to_json
    end

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    Activity.from_json(json)
  end

  def self.delete_activity(user_id, trip_id, daily_itinerary_id, activity_id)
    response = conn.delete("trips/#{trip_id}/daily_itineraries/#{daily_itinerary_id}/activities/#{activity_id}", user_id: user_id)
    response.success?
  end
end
