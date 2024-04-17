class DailyItinerary
  attr_reader :id, :trip_id, :date

  def initialize(id, trip_id, date)
    @id = id
    @trip_id = trip_id
    @date = date
  end

  def self.from_json(json)
    new(
      json.dig(:id),
      json.dig(:attributes, :trip_id),
      json.dig(:attributes, :date)
    )
  end
end
