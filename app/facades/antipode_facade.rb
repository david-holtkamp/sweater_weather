class AntipodeFacade
  attr_reader :id, :search_location

  def initialize(search_location)
    @id = nil
    @search_location = search_location
    @amypode_service = AmypodeService.new(search_location_lat_long).antipode_data
    @antipode_location_data = GoogleService.new(antipode_city_lat_long).location_data
  end

  def antipode_city
    @antipode_location_data[:address_components][0][:long_name]
  end

  def current_weather

  end

  def search_location_lat_long
    response = GoogleService.new(@search_location).geocode_data
    lat_long = response[:geometry][:location]
  end

  def antipode_city_lat_long
    @amypode_service[:attributes]
  end
end
