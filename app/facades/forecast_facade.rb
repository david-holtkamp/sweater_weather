class ForecastFacade
  attr_reader :id

  def initialize(location)
    @id = nil
    @location = location
    @google_service = GoogleService.new(location).geocode_data
    @open_weather_service = OpenWeatherService.new(lat_long).forecast_data
  end

  def forecast_location
    @google_service[:formatted_address]
  end

  def lat_long
    @google_service[:geometry][:location]
  end

  def current_forecast
    @open_weather_service.map do |current_data|
      CurrentForecast.new(current_data)
    end
  end

  def daily_forecast
    @open_weather_service[0][:daily][1..5].map do |current_data|
      DailyForecast.new(current_data)
    end
  end

  def hourly_forecast
    @open_weather_service[0][:hourly][0..7].map do |hourly_data|
      HourlyForecast.new(hourly_data)
    end
  end
end
