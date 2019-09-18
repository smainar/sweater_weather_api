class Background
  attr_reader :id,
              :url

  def initialize(raw_image_url)
    @id = 1
    @url = raw_image_url
  end
end
