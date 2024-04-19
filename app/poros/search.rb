class Search
  attr_reader :lat, :lon, :display_name, :rating, :id

  def initialize(result)
    @id = result["d"]
    @lat = result["lat"]
    @lon = result["lon"]
    @display_name = result["displayname"]
    @rating = result["rating"]
  end
end
