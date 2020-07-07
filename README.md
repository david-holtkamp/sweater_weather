# Sweater Weather 

## Overview

Sweater Weather is back-end Rails API designed to serve weather and trip information to a front-end app. It consumes 4 different APIs and exposes data to help road-trippers plan for weather given a destination and estimated arrival time. The application consumes:

- OpenWeather API for weather forecasts and prediction data
- Google Geocode API for latitude & longitude of trip origin and destination inputs
- Google Directions API to pull trip travel time for forecast predictions
- Pexel API for relevant photos of trip

## Technologies & Architecture

- Framework: Ruby on Rails
- Testing: RSpec
- JSON Serializer: FastJsonAPI
- 3rd Party APIs:
  - Google Direction Matrix API
  - Google Geocoding API
  - Pexel API
  - OpenWeather API
- Response Caching: VCR & Webmock
- Linting: Rubocop
- Test Coverage: SimpleCov
