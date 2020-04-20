class AntipodeSerializer
  include FastJsonapi::ObjectSerializer

  attributes :search_location, :antipode_city, :current_weather
end
