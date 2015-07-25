class Typeform
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
      debugger
    end
    JSON.parse response.body
  end

  private

  def request_body
    field = { type: 'picture_choice', question: @question, choices: [] }

    image_ids.each do |id|
      field[:choices] << { image_id: id.to_s, label: '' }
    end
    { title: 'Pickalo', fields: [field] }.to_json
  end

  def image_ids
    @image_urls.map do |url|
      response = @conn.post do |req|
        req.url '/v0.3/images', url: url
        req.headers['X-API-TOKEN'] = 'b5ce1b063bedf822ffc6668a0ad5d50a'
      end
      response = JSON.parse response.body
      response['id']
    end
  end
end
