class RoadtripFacade
  attr_reader :id, :origin, :destination

  def initialize(origin, destination)
    @id = nil
    @origin = origin
    @destination = destination
    @google_service = GoogleService.new(@origin).directions(@destination)
    @open_weather_service = OpenWeatherService.new(destination_lat_long).forecast_data
  end

  def travel_time
    @google_service[:duration][:text]
  end

  def arrival_forecast
    future_index = travel_time_rounded + 1
    future_forecast = @open_weather_service.first[:hourly][future_index]
    {
      temp: future_forecast[:temp],
      summary: future_forecast[:weather][0][:description]
    }
  end

  private

    def destination_lat_long
      @google_service[:end_location]
    end

    def travel_time_rounded
      minutes = (@google_service[:duration][:value] / 60).to_f
      (minutes / 60).round
    end
    #
    # def arrival_time_hour
    #    arrival_time = Time.now.to_i + travel_time_in_seconds
    # end
end
