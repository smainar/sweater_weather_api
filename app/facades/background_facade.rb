class BackgroundFacade
  attr_reader :id, :location

  def initialize(location)
    @id = 1
    @location = location
  end

  def get_image
    url = unsplash_service.unsplash_raw_hash_data[:results][0][:urls][:raw]
    Background.new(url)
  end

  def unsplash_service
    @unsplash_service ||= UnsplashService.new(@location)
  end
end
