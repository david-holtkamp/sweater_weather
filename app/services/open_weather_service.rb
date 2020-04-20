class OpenWeatherService

  def initialize(coordinates)
    @latitude = coordinates.values[0]
    @longitude = coordinates.values[1]
  end


  def forecast_data
    response = conn.get('data/2.5/onecall') do |req|
      req.params['lat'] = @latitude
      req.params['lon'] = @longitude
    end
    data = []
    data << JSON.parse(response.body, symbolize_names: true)
    data
  end

  def conn
    Faraday.new(
      url: 'https://api.openweathermap.org',
      params: {appid: ENV['OPEN_WEATHER_KEY'],
               units: "imperial"}
    )
  end
end
