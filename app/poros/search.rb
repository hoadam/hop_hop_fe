class Search
  attr_reader :lat, :lon, :display_name, :type

  def initialize(result)
    @lat = result.data["lat"]
    @lon = result.data["lon"]
    @display_name = result.data["display_name"]
    @type = result.data["type"]
  end
end
