class TypeformService
  def initialize
    @conn = Faraday.new(:url => "https://api.typeform.io") do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def create_form(question:, options:)
    response = @conn.post do |req|
      req.url "/v0.4/forms"
      req.headers["X-API-TOKEN"] = Rails.application.secrets.typeform_api_key
      req.body = request_body(question, options).to_json
    end
    JSON.parse response.body
  end

  private

  def request_body(question, options)
    {
      title: "Created with Pickalo",
      webhook_submit_url: "http://pickalo.herokuapp.com/answers",
      fields: [
        {
          type: "multiple_choice",
          question: question,
          choices: options.map { |o| { label: o } }
        }
      ]
    }
  end
end
