class CloudinaryAdapter
  def initialize(images)
    @images = images
  end

  def get_urls
    @images.map do |image|
      Cloudinary::Uploader.upload(image)
    end
  end
end
