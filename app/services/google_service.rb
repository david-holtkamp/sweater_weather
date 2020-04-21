class GoogleService

  def initialize(location)
    @location = location
  end

  def directions(destination)
    response = conn.get('maps/api/directions/json') do |req|
      req.params['destination'] = destination
      req.params['origin'] = @location
    end
    JSON.parse(response.body, symbolize_names: true)[:routes][0][:legs][0]
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
