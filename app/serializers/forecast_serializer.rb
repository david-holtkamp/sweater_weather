class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  attributes :forecast_location, :current_forecast, :daily_forecast, :hourly_forecast
end
