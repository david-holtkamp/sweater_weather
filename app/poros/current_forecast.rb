class CurrentForecast

  def initialize(forecast_data)
    @datetime = Time.at(forecast_data[:current][:dt]).strftime("%B %e %I:%M%p")
    @feels_like = forecast_data[:current][:feels_like]
    @humidity = forecast_data[:current][:humidity]
    # @visibility = (forecast_data[:current][:visibility] / 1609.344).round
    @uv_index = forecast_data[:current][:uvi]
    @temp = forecast_data[:current][:temp]
    @description = forecast_data[:current][:weather][0][:description]
    @icon = forecast_data[:current][:weather][0][:icon]
    @high = forecast_data[:daily][0][:temp][:max]
    @low = forecast_data[:daily][0][:temp][:min]
    @sunrise = Time.at(forecast_data[:current][:sunrise]).strftime("%I:%M%p")
    @sunset = Time.at(forecast_data[:current][:sunset]).strftime("%I:%M%p")
  end
end
