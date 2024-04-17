class Trip
  attr_reader :id,
              :name,
              :location,
              :start_date,
              :end_date,
              :status,
              :total_budget,
              :total_expenses,
              :daily_itineraries,
              :activities


  def initialize(id, name, location, start_date, end_date, status, total_budget, total_expenses, daily_itineraries, activities)
    @id = id
    @name = name
    @location = location
    @start_date = start_date
    @end_date = end_date
    @status = status
    @total_budget = total_budget
    @total_expenses = total_expenses
    @daily_itineraries = daily_itineraries
    @activities = activities
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
      process_daily_itineraries(json),
      process_activities_by_date(json)
    )
  end

  private

  def self.process_daily_itineraries(json)
    daily_itineraries = json.dig(:included).to_a.select { |item| item[:type] == 'daily_itinerary' }
    daily_itineraries.map { |item| DailyItinerary.from_json(item) }
  end

  def self.process_activities_by_date(json)
    raw = json.dig(:data, :attributes, :daily_itineraries).to_h.with_indifferent_access
    raw.transform_values do |activities_json|
      activities_json.map do |activity|
        Activity.from_json(activity[:data])
      end
    end
  end
end
