class PexelService
  def initialize(location)
    @location = location.split(',')[0]
  end

  def background_image_data
    response = conn.get('v1/search') do |req|
      req.params['query'] = @location
      req.params['per_page'] = 1
      req.params['page'] = 1
    end
    JSON.parse(response.body, symbolize_names: true)[:photos]
  end

  def conn
    Faraday.new(
      url: 'https://api.pexels.com',
      headers: {Authorization: ENV['PEXEL_API_KEY']}
    )
  end
end
