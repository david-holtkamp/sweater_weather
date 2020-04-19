require 'rails_helper'

RSpec.describe 'I can receive a forecast for a city' do
  it 'returns all necessary info based on wireframes' do

    get '/api/v1/forecast?location=denver,co', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
    expect(response).to be_successful

    location = JSON.parse(response.body, symbolize_names: true)
    expect(location.keys.count).to eq(2)
    expect(location[:lat]).not_to be_empty
    expect(location[:lng]).not_to be_empty
  end
end
