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

## Endpoints

All endpoints are built on this API URL:
```
http://localhost:3000/api/v1/
```
Note the appropriate HTTP verb for each endpoint.

### Forecast

Retrieve detailed weather information for a given city, including:
- Current conditions
- Location details
- Tonight's weather (at 8pm, or currently if between 8pm and midnight)
- Hourly forecasts for next 8 hours
- Daily forecasts for next 5 days

Endpoint:
```
/forecast
```

Query Parameter(s):
- `location`, which should be a string containing a city and state, comma-separated (e.g., "denver,co").

HTTP Request Example:
```
GET http://localhost:3000/api/v1/forecast?location=denver,co
```

Response example:
```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "forecast_location": "Denver, CO, USA",
            "current_forecast": [
                {
                    "datetime": "July 31 01:17PM",
                    "feels_like": 78.6,
                    "humidity": 28,
                    "uv_index": 10.59,
                    "temp": 83.7,
                    "description": "clear sky",
                    "icon": "01d",
                    "high": 85.26,
                    "low": 73.99,
                    "sunrise": "05:58AM",
                    "sunset": "08:13PM"
                }
            ],
            "daily_forecast": [
                {
                    "day": "Saturday",
                    "icon": "10d",
                    "summary": "Rain",
                    "precipitation": 16,
                    "high": 87.6,
                    "low": 68.79
                },
                {
                    "day": "Sunday",
                    "icon": "10d",
                    "summary": "Rain",
                    "precipitation": 62,
                    "high": 86.41,
                    "low": 67.91
                },
                {
                    "day": "Monday",
                    "icon": "10d",
                    "summary": "Rain",
                    "precipitation": 4,
                    "high": 88.9,
                    "low": 67.6
                },
                {
                    "day": "Tuesday",
                    "icon": "10d",
                    "summary": "Rain",
                    "precipitation": 9,
                    "high": 93.27,
                    "low": 71.94
                },
                {
                    "day": "Wednesday",
                    "icon": "01d",
                    "summary": "Clear",
                    "precipitation": 0,
                    "high": 96.15,
                    "low": 70.5
                }
            ],
            "hourly_forecast": [
                {
                    "time": "01q PM",
                    "icon": "01d",
                    "temp": 83.7
                },
                {
                    "time": "02q PM",
                    "icon": "01d",
                    "temp": 84.67
                },
                {
                    "time": "03q PM",
                    "icon": "01d",
                    "temp": 86.22
                },
                {
                    "time": "04q PM",
                    "icon": "01d",
                    "temp": 87.44
                },
                {
                    "time": "05q PM",
                    "icon": "01d",
                    "temp": 86.85
                },
                {
                    "time": "06q PM",
                    "icon": "10d",
                    "temp": 81.72
                },
                {
                    "time": "07q PM",
                    "icon": "04d",
                    "temp": 78.89
                },
                {
                    "time": "08q PM",
                    "icon": "04d",
                    "temp": 75.79
                }
            ]
        }
    }
}
```

### Backgrounds

Retrieve a background image URL from Unsplash for a given city, which can be resized to fit one's needs.

Endpoint:
```
/backgrounds
```

Query Parameter(s):
- `location`, which should be a string containing a city and state, comma-separated (e.g., "denver,co").

HTTP Request Example:
```
GET http://localhost:3000/api/v1/backgrounds?location=denver,co
```

Response example:
```json
{
    "data": {
        "id": null,
        "type": "background",
        "attributes": {
            "background_image": "https://www.pexels.com/photo/union-station-building-2706750/"
        }
    }
}
```

### Users

Submit a user's email, password, and password confirmation to create that user in the database and receive a unique API key for the user.

POST Request Body Parameter(s):
- `email`, which is a string value and must be unique in the database.
- `password`, which is a string value.
- `password_confirmation`, which is a string value and must be present and match the `password`.

Endpoint:
```
/users
```

HTTP Request example:
```
POST http://localhost:3000/api/v1/users
```
Headers example:
```
Content-Type: application/json
Accept: application/json
```
Body example:
```json
{
  "email": "email@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

Response example:
```json
{
    "data": {
        "id": "8",
        "type": "user",
        "attributes": {
            "email": "david100@example.com",
            "api_key": "3AHFvE8ShN8XKGEGee1BphDy"
        }
    }
}
```

If there is a problem with the parameters provided, a JSON:API error object will be returned containing details about which parameter caused the error.

Error example:
```json
{
    "errors": [
        {
            "status": "400",
            "source": {
                "pointer": "/api/v1/users",
                "parameter": "email, password_confirmation"
            },
            "title": "Invalid Request",
            "detail": "Email has already been taken, Password confirmation doesn't match Password."
        }
    ]
}
```
