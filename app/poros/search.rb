class Search
  attr_reader :lat, :lon, :display_name, :type, :id

  def initialize(result)
    @id = result.data["place_id"]
    @lat = result.data["lat"]
    @lon = result.data["lon"]
    @display_name = result.data["display_name"]
    @type = result.data["type"]
  end
end
