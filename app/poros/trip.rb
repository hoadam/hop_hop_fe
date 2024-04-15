class Trip
  attr_reader :id,
              :name,
              :location,
              :start_date,
              :end_date,
              :status,
              :total_budget,
              :total_expenses,
              :daily_itineraries

  def initialize(id, name, location, start_date, end_date, status, total_budget, total_expenses, daily_itineraries)
    # binding.pry
    @id = id
    @name = name
    @location = location
    @start_date = start_date
    @end_date = end_date
    @status = status
    @total_budget = total_budget
    @total_expenses = total_expenses
    @daily_itineraries = daily_itineraries
  end

  def self.from_json(json)
    new(
      json.dig(:data, :id),
      json.dig(:data, :attributes, :name),
      json.dig(:data, :attributes, :location),
      json.dig(:data, :attributes, :start_date),
      json.dig(:data, :attributes, :end_date),
      json.dig(:data, :attributes, :status),
      json.dig(:data, :attributes, :total_budget),
      json.dig(:data, :attributes, :total_expenses),
      json.dig(:included).to_a.select { |item| item[:type] == 'daily_itinerary' }.map { |item| DailyItinerary.from_json(item) }
    )
  end
end
