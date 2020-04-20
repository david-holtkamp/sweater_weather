class GoogleService

  def initialize(location)
    @location = location
  end

  def lat_long
    "#{@location[:lat]},#{@location[:long]}"
  end

  def location_data
    response = conn.get('maps/api/geocode/json') do |req|
      req.params['latlng'] = lat_long
    end
    JSON.parse(response.body, symbolize_names: true)[:results][0]
  end

  def geocode_data
    response = conn.get('maps/api/geocode/json') do |req|
      req.params['address'] = @location
    end
    JSON.parse(response.body, symbolize_names: true)[:results][0]
  end

  def conn
    Faraday.new(
      url: 'https://maps.googleapis.com',
      params: {key: ENV['GOOGLE_API_KEY']}
    )
  end
end
