require 'rails_helper'

RSpec.describe 'I can create a user', :type => :request do
  it 'can take in registration info and return an API key' do

    post '/api/v1/users', params: {
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    }.to_json, headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to be_successful
    user_key = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    user = User.last
    expect(user_key).to eq({api_key: user.api_key, email: 'test@example.com'})
  end

  it 'will not make a user with a duplicate email address' do
    user = User.create({
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
    })

    post '/api/v1/users', params: {
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    }.to_json, headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to_not be_successful
    errored_response = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    expect(errored_response[:failed]).to eq("Email has already been taken")
  end

  it 'will not make a user with invalid fields' do
    user = User.create({
    email: '',
    password: 'password',
    password_confirmation: 'password'
    })

    post '/api/v1/users', params: {
      email: '',
      password: 'password',
      password_confirmation: 'password'
    }.to_json, headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to_not be_successful
    errored_response = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    expect(errored_response[:failed]).to eq("Email can't be blank")
  end

  it 'will not make a user with missing fields' do
    user = User.create({
    email: 'test_2@example.com',
    password: 'password',
    password_confirmation: 'password_1'
    })

    post '/api/v1/users', params: {
      email: 'test_2@example.com',
      password: 'password',
      password_confirmation: 'password_1'
    }.to_json, headers: {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    expect(response).to_not be_successful
    errored_response = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]
    expect(errored_response[:failed]).to eq("Password confirmation doesn't match Password")
  end
end
