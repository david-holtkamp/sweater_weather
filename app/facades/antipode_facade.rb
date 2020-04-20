class AntipodeFacade
  attr_reader :id, :search_location

  def initialize(search_location)
    @id = nil
    @search_location = search_location
    search_location_coords = find_search_location_lat_long
    @amypode_service = AmypodeService.new(search_location_coords).antipode_data
    @antipode_location_data = GoogleService.new(antipode_city_lat_long).location_data
    @antipode_weather_data = OpenWeatherService.new(antipode_city_lat_long).forecast_data
    # @forecast = Forecast.new(@antipode_weather_data)
  end

  def location_name
    @antipode_location_data[:address_components][0][:long_name]
  end

  def forecast
      # Forecast.new(@antipode_weather_data)

    {
      summary: @antipode_weather_data[0][:current][:weather][0][:description],
      current_temperature: @antipode_weather_data[0][:current][:temp].round
    }
  end

  def find_search_location_lat_long
    response = GoogleService.new(@search_location).geocode_data
    response[:geometry][:location]
  end

  def antipode_city_lat_long
    @amypode_service[:attributes]
  end
end
