class Search
  attr_reader :displayname, :lat, :lon, :id, :address, :rating

  def initialize(search_params)
    @lat = search_params[:lat]
    @lon = search_params[:lon]
    @displayname = search_params[:displayname]
    @rating = search_params[:rating]
    @id = search_params[:id]
    @address = search_params[:search]
  end
end
