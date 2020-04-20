class AmypodeService

  def initialize(lat_long)
    @lat = lat_long[:lat]
    @long = lat_long[:lng]
  end

  def antipode_data
    response = conn.get
    parsed = JSON.parse(response.body, symbolize_names: true)[:data]
  end


  def conn
    Faraday.new("https://amypode.herokuapp.com/api/v1/antipodes") do |req|
      req.headers[:api_key] = ENV['AMYPODE_API_KEY']
      req.params['lat'] = @lat
      req.params['long'] = @long
      req.adapter Faraday.default_adapter
    end
  end
end
