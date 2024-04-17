class Accommodation
  attr_reader :id,
              :name,
              :address,
              :lat,
              :lon,
              :type_of_accommodation,
              :expenses,
              :check_in,
              :check_out

  def initialize(id, name, address, lat, lon, type_of_accommodation, expenses, check_in, check_out)
    @id = id
    @name = name
    @address = address
    @lat = lat
    @lon = lon
    @type_of_accommodation = type_of_accommodation
    @expenses = expenses
    @check_in = Date.parse(check_in) if check_in
    @check_out = Date.parse(check_out) if check_out
  end

  def self.from_json(json)
    new(
      json.dig(:id),
      json.dig(:attributes, :name),
      json.dig(:attributes, :address),
      json.dig(:attributes, :lat),
      json.dig(:attributes, :lon),
      json.dig(:attributes, :type_of_accommodation),
      json.dig(:attributes, :expenses),
      json.dig(:attributes, :check_in),
      json.dig(:attributes, :check_out)
    )
  end
end
