class RoadtripForecast
  attr_reader :temp, :summary

  def initialize(future_forecast_data)
    @temp = future_temp(future_forecast_data)
    @summary = future_summary(future_forecast_data)
  end

  private

  def future_temp(future_forecast_data)
    future_forecast_data[:temp]
  end

  def future_summary(future_forecast_data)
    future_forecast_data[:weather][0][:description]
  end
end
