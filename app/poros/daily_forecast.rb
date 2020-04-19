class DailyForecast

  def initialize(forecast_data)
    @day = Time.at(forecast_data[:dt]).strftime('%A')
    @icon = forecast_data[:weather][0][:icon]
    @summary = forecast_data[:weather][0][:main]
    @precipitation = precip_summary(forecast_data)
    @high = forecast_data[:temp][:max]
    @low = forecast_data[:temp][:min]
  end

  def precip_summary(forecast_data)
    if forecast_data[:rain] && forecast_data[:snow]
        (forecast_data[:rain] + forecast_data[:snow] * 25.4).round
      elsif forecast_data[:rain]
        (forecast_data[:rain] * 25.4).round
      elsif forecast_data[:snow]
        (forecast_data[:snow] * 25.4).round
      else
        0
    end
  end
end





















# def compiled_forecast
#   {"next_day": next_day_weather,
#   "day_2_weather": day_2_weather,
#   "day_3_weather": day_3_weather,
#   "day_4_weather": day_4_weather,
#   "day_5_weather": day_5_weather}
# end

  # def next_day_weather
  #   @day = @forecast_data[:daily][1][:dt]
  #   @icon = @forecast_data[:daily][1][:weather][0][:icon]
  #   @main = @forecast_data[:daily][1][:weather][0][:main]
  #   @rain = @forecast_data[:daily][1][:rain]
  #   @high = @forecast_data[:daily][1][:temp][:max]
  #   @low = @forecast_data[:daily][1][:temp][:min]
  #   data = {"day": @day,
  #     "icon": @icon,
  #     "main": @main,
  #     "rain": @rain,
  #     "high": @high,
  #     "low": @low
  #   }
  #   data
  # end
  #
  # def day_2_weather
  #   @day = @forecast_data[:daily][2][:dt]
  #   @icon = @forecast_data[:daily][2][:weather][0][:icon]
  #   @main = @forecast_data[:daily][2][:weather][0][:main]
  #   @rain = @forecast_data[:daily][2][:rain]
  #   @high = @forecast_data[:daily][2][:temp][:max]
  #   @low = @forecast_data[:daily][2][:temp][:min]
  #   data = {"day": @day,
  #     "icon": @icon,
  #     "main": @main,
  #     "rain": @rain,
  #     "high": @high,
  #     "low": @low
  #   }
  #   data
  # end
  #
  # def day_3_weather
  #   @day = @forecast_data[:daily][3][:dt]
  #   @icon = @forecast_data[:daily][3][:weather][0][:icon]
  #   @main = @forecast_data[:daily][3][:weather][0][:main]
  #   @rain = @forecast_data[:daily][3][:rain]
  #   @high = @forecast_data[:daily][3][:temp][:max]
  #   @low = @forecast_data[:daily][3][:temp][:min]
  #   data = {"day": @day,
  #     "icon": @icon,
  #     "main": @main,
  #     "rain": @rain,
  #     "high": @high,
  #     "low": @low
  #   }
  #   data
  # end
  #
  # def day_4_weather
  #   @day = @forecast_data[:daily][4][:dt]
  #   @icon = @forecast_data[:daily][4][:weather][0][:icon]
  #   @main = @forecast_data[:daily][4][:weather][0][:main]
  #   @rain = @forecast_data[:daily][4][:rain]
  #   @high = @forecast_data[:daily][4][:temp][:max]
  #   @low = @forecast_data[:daily][4][:temp][:min]
  #   data = {"day": @day,
  #     "icon": @icon,
  #     "main": @main,
  #     "rain": @rain,
  #     "high": @high,
  #     "low": @low
  #   }
  #   data
  # end
  #
  # def day_5_weather
  #   @day = @forecast_data[:daily][5][:dt]
  #   @icon = @forecast_data[:daily][5][:weather][0][:icon]
  #   @main = @forecast_data[:daily][5][:weather][0][:main]
  #   @rain = @forecast_data[:daily][5][:rain]
  #   @high = @forecast_data[:daily][5][:temp][:max]
  #   @low = @forecast_data[:daily][5][:temp][:min]
  #   data = {"day": @day,
  #     "icon": @icon,
  #     "main": @main,
  #     "rain": @rain,
  #     "high": @high,
  #     "low": @low
  #   }
  #   data
  # end
