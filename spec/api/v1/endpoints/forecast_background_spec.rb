require 'rails_helper'

RSpec.describe 'I can receive a background image for a city' do
  it 'returns an appropriate url' do

    get '/api/v1/backgrounds?location=denver,co', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
    expect(response).to be_successful

    background_image = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    expect(background_image[:background_image]).to be_a String
  end

  it 'returns a default image if none are returned ' do

    get '/api/v1/backgrounds?location=cleveland,oh', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
    expect(response).to be_successful

    background_image = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    expect(background_image[:background_image]).not_to be_falsey
    expect(background_image[:background_image]).to eq("https://images.unsplash.com/photo-1537210249814-b9a10a161ae4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80")
  end
end
