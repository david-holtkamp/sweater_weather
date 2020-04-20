require 'rails_helper'

RSpec.describe 'I can find antipode city of Hong Kong' do
  it 'returns all necessary info based on spec' do

    get '/api/v1/antipode?location=hongkong', headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
    expect(response).to be_successful

    city = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
  end
end
