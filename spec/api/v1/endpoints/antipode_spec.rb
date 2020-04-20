require 'rails_helper'

RSpec.describe 'I can find antipode city of Hong Kong' do
  it 'returns all necessary info based on spec' do

    get '/api/v1/antipode?location=Hong Kong', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
    expect(response).to be_successful

    city_info = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    
    expect(city_info[:location_name]).to be_a String
    expect(city_info[:location_name]).to eq("Ruta Provincial 69")
    expect(city_info[:forecast].keys).to eq([:summary, :current_temperature])
    expect(city_info[:forecast][:summary]).to be_a String
    expect(city_info[:forecast][:summary]).to eq("clear sky")
    expect(city_info[:forecast][:current_temperature]).to be_a Integer
    expect(city_info[:forecast][:current_temperature]).to eq(55)
    expect(city_info[:search_location]).to be_a String
    expect(city_info[:search_location]).to eq("Hong Kong")
  end
end
