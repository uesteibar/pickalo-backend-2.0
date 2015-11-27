class TypeformService
  def initialize
    @conn = Faraday.new(:url => "https://api.typeform.io") do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
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
      webhook_submit_url: "https://78edee3a.ngrok.com/answers",
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
