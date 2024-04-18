class DiscoverFacade
  attr_reader :search_params
  def initialize(search_params)
    @search_params = search_params
  end

  def find_location
    Geocoder.search(@search_params)
  end

  def search_objects
    find_location.map{|result| Search.new(result)}
  end

  def json_data
    find_location.to_json
  end

  def filtered_search_objects
    search_objects.uniq {|object| object.display_name}
  end

  def empty?
    search_objects.empty?
  end
end
