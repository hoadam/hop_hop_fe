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
    @id = id
    @name = name
    @location = location
    @start_date = Date.parse(start_date) if start_date
    @end_date = Date.parse(end_date) if end_date
    @status = status
    @total_budget = total_budget
    @total_expenses = total_expenses
    @daily_itineraries = daily_itineraries
  end

  def self.from_json(json)
    new(
      json.dig(:id),
      json.dig(:attributes, :name),
      json.dig(:attributes, :location),
      json.dig(:attributes, :start_date),
      json.dig(:attributes, :end_date),
      json.dig(:attributes, :status),
      json.dig(:attributes, :total_budget),
      json.dig(:attributes, :total_expenses),
      json.dig(:attributes, :daily_itineraries)
    )
  end
end
