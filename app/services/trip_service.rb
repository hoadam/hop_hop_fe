class TripService
  def self.conn
    conn = Faraday.new(url: 'http://127.0.0.1:3000/api/v1')
  end

  def self.get_url(url, params = {})
    response = conn.get(url, params)

    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.get_trips(user_id)
    response = get_url('trips', user_id: user_id)
    response.map do |json|
      Trip.from_json(json)
    end
  end

  def self.trip_details(user_id, trip_id)
    json = get_url("trips/#{trip_id}", user_id: user_id)

    Trip.from_json(json)
  end

  def self.create_trip(user_id, trip_params)
    response = conn.post("trips", trip: trip_params.merge(user_id: user_id))
    json = JSON.parse(response.body, symbolize_names: true)[:data]
    Trip.from_json(json)
  end

  def self.update_trip(user_id, trip_id, trip_params)
    response = conn.put("trips/#{trip_id}", user_id: user_id, trip: trip_params.merge(user_id: user_id))
    json = JSON.parse(response.body, symbolize_names: true)[:data]
    Trip.from_json(json)
  end

  def self.delete_trip(user_id, trip_id)
    response = conn.delete("trips/#{trip_id}", user_id: user_id)
    response.success?
  end
end
