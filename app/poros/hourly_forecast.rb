class HourlyForecast

  def initialize(forecast_data)
    @time = Time.at(forecast_data[:dt]).strftime('%Iq %p')
    @icon = forecast_data[:weather][0][:icon]
    @temp = forecast_data[:temp]
  end
end
