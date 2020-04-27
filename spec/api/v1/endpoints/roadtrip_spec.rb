require 'rails_helper'

describe 'I can create a road trip', :type => :request do
  it 'can take in road trip info and return travel time and arrival forecast' do
    user = User.create({
      email: "test@example.com",
      password: "password",
      password_confirmation: "password"
    })

    post '/api/v1/road_trip', params: {
        origin: "Denver,CO",
        destination: "Pueblo,CO",
        api_key: user.api_key
      }.to_json, headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

    expect(response).to be_successful
    road_trip = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    expect(road_trip.keys).to eq([:origin, :destination, :travel_time, :arrival_forecast])
    expect(road_trip[:origin]).not_to be_empty
    expect(road_trip[:origin]).to be_a String
    expect(road_trip[:destination]).not_to be_empty
    expect(road_trip[:destination]).to be_a String
    expect(road_trip[:travel_time]).not_to be_empty
    expect(road_trip[:travel_time]).to be_a String
    expect(road_trip[:arrival_forecast].keys).to eq([:temp, :summary])
    expect(road_trip[:arrival_forecast][:temp]).to be_a Float
    expect(road_trip[:arrival_forecast][:summary]).not_to be_empty
    expect(road_trip[:arrival_forecast][:summary]).to be_a String
  end

  it 'will not take in road trip info without a valid API key' do
    post '/api/v1/road_trip', params: {
        origin: "Denver,CO",
        destination: "Pueblo,CO"
      }.to_json, headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

    expect(response).to_not be_successful
    road_trip = JSON.parse(response.body, symbolize_names: true)

    expect(road_trip[:failed]).to eq('Unauthorized')
  end
end
