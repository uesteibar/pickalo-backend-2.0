class Typeform
  attr_reader :images

  def initialize(question, image_urls)
    @question = question
    @image_urls = image_urls
    @conn = Faraday.new(url: 'https://api.typeform.io') do |faraday|
      faraday.request :url_encoded
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
    end
  end

  def create_form
    rb = request_body
    response = @conn.post do |req|
      req.url '/v0.3/forms'
      req.headers['X-API-TOKEN'] = 'b5ce1b063bedf822ffc6668a0ad5d50a'
      req.headers['Content-Type'] = 'application/json'
      req.body = rb
    end

    body = JSON.parse response.body

    body['fields'].first['choices'].map! do |choice|
      corresponding_image = @images.find do |image|
        image[:id] == choice['image_id'].to_i
      end
      choice.merge({image_url: corresponding_image[:url]})
    end

    body
  end

  private

  def request_body
    field = { type: 'picture_choice', question: @question, choices: [] }

    generate_images.each do |image|
      field[:choices] << { image_id: image[:id].to_s, label: image[:id].to_s }
    end
    { title: 'Pickalo', webhook_submit_url: "http://pickalo.herokuapp.com/answers", fields: [field] }.to_json
  end

  def generate_images
    @images = @image_urls.map do |url|
      response = @conn.post do |req|
        req.url '/v0.3/images', url: url['url']
        req.headers['X-API-TOKEN'] = 'b5ce1b063bedf822ffc6668a0ad5d50a'
      end
      response = JSON.parse response.body
      { id: response['id'], url: url['url'] }
    end
  end
end
