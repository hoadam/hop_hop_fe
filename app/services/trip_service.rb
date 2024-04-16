class TripService < HophopService
  def self.get_trips(user_id)
    response = get_url('trips', user_id: user_id)
    return [] if response[:data].blank?

    response[:data].map do |json|
      Trip.new(
        json.dig(:id),
        json.dig(:attributes, :name),
        json.dig(:attributes, :location),
        json.dig(:attributes, :start_date),
        json.dig(:attributes, :end_date),
        json.dig(:attributes, :status),
        json.dig(:attributes, :total_budget),
        json.dig(:attributes, :total_expenses),
        []
      )
    end
  end

  def self.trip_details(user_id, trip_id)
    json = get_url("trips/#{trip_id}", user_id: user_id)
    Trip.from_json(json)
  end

  def self.create_trip(user_id, trip_params)
    response = conn.post("trips", trip: trip_params.merge(user_id: user_id))
    json = JSON.parse(response.body, symbolize_names: true)
    Trip.from_json(json)
  end

  def self.update_trip(user_id, trip_id, trip_params)
    response = conn.put("trips/#{trip_id}") do |req|
      req.body = {
        user_id: user_id,
        trip: trip_params.merge(user_id: user_id)
      }.to_json
    end
    json = JSON.parse(response.body, symbolize_names: true)
    Trip.from_json(json)
  end

  def self.delete_trip(user_id, trip_id)
    response = conn.delete("trips/#{trip_id}", user_id: user_id)
    response.success?
  end
end
