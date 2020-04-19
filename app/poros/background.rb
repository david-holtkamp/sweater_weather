class Background
  attr_reader :id

  def initialize(location)
    @id = nil
    @background_image_service = PexelService.new(location).background_image_data
  end

  def background_image
    if @background_image_service.empty?
      default_image
    else
      @background_image_service[0][:url]
    end
  end

  def default_image
    "https://images.unsplash.com/photo-1537210249814-b9a10a161ae4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80"
  end
end
