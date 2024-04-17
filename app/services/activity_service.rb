class ActivityService
  def self.conn
    conn = Faraday.new(url: 'http://127.0.0.1:3000/api/v1')
  end

  def self.get_url(url, params = {})
    response = conn.get(url, params)

    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.daily_activities(user_id, trip_id, daily_itinerary_id)
    response = get_url("trips/#{trip_id}/daily_itineraries/#{daily_itinerary_id}/activities", user_id: user_id)
    response.map do |json|
      Activity.from_json(json)
    end
  end

  def self.create_activity(user_id, trip_id, daily_itinerary_id, activity_params)
    response = conn.post("trips/#{trip_id}/daily_itineraries/#{daily_itinerary_id}/activities", activity: activity_params.merge(user_id: user_id))

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    Activity.from_json(json)
  end

  def self.update_activity(user_id, trip_id, daily_itinerary_id, activity_id, activity_params)
    response = conn.put("trips/#{trip_id}/daily_itineraries/#{daily_itinerary_id}/activities/#{activity_id}", activity: activity_params.merge(user_id: user_id))
    json = JSON.parse(response.body, symbolize_names: true)[:data]
    Activity.from_json(json)
  end

  def self.delete_activity(user_id, trip_id, daily_itinerary_id, activity_id)
    response = conn.delete("trips/#{trip_id}/daily_itineraries/#{daily_itinerary_id}/activities/#{activity_id}", user_id: user_id)
    response.success?
  end
end
