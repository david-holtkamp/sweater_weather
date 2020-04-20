class AntipodeFacade
  attr_reader :id, :search_location

  def initialize(search_location)
    @id = nil
    @search_location = search_location
    require "pry"; binding.pry
  end

  def antipode_city

  end

  def current_weather

  end

  def search_location_lat_long
    response = GoogleService.new(@search_location).geocode_data
    response[:geometry][:location]
  end

  def amypode_service
    lat = search_location_lat_long[:lat]
    long = search_location_lat_long[:lng]
    AmypodeService.new(lat, long).antipode_data
  end


end
