class Search
  attr_reader :id, :lat, :lon, :name, :address, :rank

  def initialize(result)
    result = JSON.parse(result, symbolize_names: true)
    @id = result[:data][:place_id]
    @lat = result[:data][:lat]
    @lon = result[:data][:lon]
    @name = result[:data][:name]
    @address = convert_address(result)
    @rank = result[:data][:place_rank]
  end

  def convert_address(result)
    address = [
      result[:data][:address][:city],
      result[:data][:address][:county],
      result[:data][:address][:country]
    ]
    address.join(", ")
  end
end
