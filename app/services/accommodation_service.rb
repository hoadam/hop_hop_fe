class AccommodationService
  def self.conn
    conn = Faraday.new(url: 'http://127.0.0.1:3000/api/v1')
  end

  def self.get_url(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def self.get_accommodations(user_id, trip_id)
    response = get_url("trips/#{trip_id}/accommodations", user_id: user_id)
    response.map { |json| Accommodation.from_json(json) }
  end

  def self.accommodation_details(user_id, trip_id, accommodation_id)
    json = get_url("trips/#{trip_id}/accommodations/#{accommodation_id}", user_id: user_id)
    Accommodation.from_json(json)
  end

  def self.create_accommodation(user_id, trip_id, accommodation_params)
    response = conn.post("trips/#{trip_id}/accommodations", user_id: user_id, accommodation: accommodation_params)
    json = JSON.parse(response.body, symbolize_names: true)[:data]
    Accommodation.from_json(json)
  end

  def self.update_accommodation(user_id, trip_id, accommodation_id, accommodation_params)
    response = conn.put("trips/#{trip_id}/accommodations/#{accommodation_id}", user_id: user_id, accommodation: accommodation_params)
    json = JSON.parse(response.body, symbolize_names: true)[:data]
    Accommodation.from_json(json)
  end

  def self.delete_accommodation(user_id, trip_id, accommodation_id)
    response = conn.delete("trips/#{trip_id}/accommodations/#{accommodation_id}", user_id: user_id)
    response.success?
  end
end
