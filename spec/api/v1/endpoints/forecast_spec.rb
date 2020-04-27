require 'rails_helper'

RSpec.describe 'I can receive a forecast for a city', :type => :request do
  it 'returns all necessary info based on wireframes' do

    # get '/api/v1/forecast?location=kauai,hi', headers: {
    get '/api/v1/forecast?location=denver,co', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
    expect(response).to be_successful

    forecast = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(forecast[:forecast_location]).to be_a String
    expect(forecast[:current_forecast].length).to eq(1)
    expect(forecast[:current_forecast][0].keys).to eq([:datetime, :feels_like, :humidity, :uv_index, :temp, :description, :icon, :high, :low, :sunrise, :sunset])
    expect(forecast[:daily_forecast].length).to eq(5)
    expect(forecast[:daily_forecast][0].keys).to eq([:day, :icon, :summary, :precipitation, :high, :low])
    expect(forecast[:hourly_forecast].length).to eq(8)
    expect(forecast[:hourly_forecast][0].keys).to eq([:time, :icon, :temp])
  end
end
