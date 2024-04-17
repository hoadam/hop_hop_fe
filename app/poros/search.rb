class Search
  attr_reader :lat, :lon, :display_name

  def initialize(result)
    @lat = result.data["lat"]
    @lon = result.data["lon"]
    @display_name = result.data["display_name"]
  end
end
