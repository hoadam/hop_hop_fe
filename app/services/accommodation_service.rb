class AccommodationService < HophopService
  def self.get_accommodations(user_id, trip_id)
    response = get_url("trips/#{trip_id}/accommodations", user_id: user_id)
    response[:data].map { |json| Accommodation.from_json(json) }
  end

  def self.accommodation_details(user_id, trip_id, accommodation_id)
    json = get_url("trips/#{trip_id}/accommodations/#{accommodation_id}", user_id: user_id)
    Accommodation.from_json(json[:data])
  end

  def self.create_accommodation(user_id, trip_id, accommodation_params)
    response = conn.post("trips/#{trip_id}/accommodations") do |req|
      req.body = {
        user_id: user_id,
        accommodation: accommodation_params
      }.to_json
    end

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    Accommodation.from_json(json)
  end

  def self.update_accommodation(user_id, trip_id, accommodation_id, accommodation_params)
    response = conn.put("trips/#{trip_id}/accommodations/#{accommodation_id}") do |req|
      req.body = {
        user_id: user_id,
        accommodation: accommodation_params
      }.to_json
    end

    json = JSON.parse(response.body, symbolize_names: true)[:data]
    Accommodation.from_json(json)
  end

  def self.delete_accommodation(user_id, trip_id, accommodation_id)
    response = conn.delete("trips/#{trip_id}/accommodations/#{accommodation_id}", user_id: user_id)
    response.success?
  end
end
