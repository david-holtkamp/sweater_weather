require 'rails_helper'

RSpec.describe 'testing for precipitation summary' do
  before :each do
    @forecast_data1 = {
      dt: 1587405600,
      sunrise: 1587384847,
      :temp=>{:day=>59.45, :min=>43.43, :max=>64.51, :night=>54.34, :eve=>63.28, :morn=>43.43},
      :feels_like=>{:day=>52.7, :night=>47.43, :eve=>52.12, :morn=>37.62},
      :pressure=>1013,
      :humidity=>18,
      :dew_point=>25.16,
      :wind_speed=>2.48,
      :wind_deg=>117,
      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
      :clouds=>0,
      :uvi=>7.7,
      :rain=>2,
      :snow=>4
    }

    @forecast_data2 ={
      dt: 1587405600,
      sunrise: 1587384847,
      :temp=>{:day=>59.45, :min=>43.43, :max=>64.51, :night=>54.34, :eve=>63.28, :morn=>43.43},
      :feels_like=>{:day=>52.7, :night=>47.43, :eve=>52.12, :morn=>37.62},
      :pressure=>1013,
      :humidity=>18,
      :dew_point=>25.16,
      :wind_speed=>2.48,
      :wind_deg=>117,
      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
      :clouds=>0,
      :uvi=>7.7,
      :snow=>4
    }

    @daily_forecast1 = DailyForecast.new(@forecast_data1)
    @daily_forecast2 = DailyForecast.new(@forecast_data2)
  end

  it "I can return right amount of precipitation if there is rain and snow" do
    expect(@daily_forecast1.precip_summary(@forecast_data1)).to eq(104)
  end

  it "I can return right amount of precipitation if there is just snow" do
    expect(@daily_forecast2.precip_summary(@forecast_data2)).to eq(102)
  end
end
