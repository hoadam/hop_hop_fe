class Activity
  attr_reader :id, :name, :address, :lat, :lon, :rating, :time, :expenses, :description

  def initialize(id, name, address, lat, lon, rating, time, expenses, description)
    @id = id
    @name = name
    @address = address
    @lat = lat
    @lon = lon
    @rating = rating
    @time = time
    @expenses = expenses
    @description = description
  end

  def self.from_json(json)
    new(
      json.dig(:id),
      json.dig(:attributes, :name),
      json.dig(:attributes, :address),
      json.dig(:attributes, :lat),
      json.dig(:attributes, :lon),
      json.dig(:attributes, :rating),
      json.dig(:attributes, :time),
      json.dig(:attributes, :expenses),
      json.dig(:attributes, :description),
    )
  end
end
