class FormsController < ApplicationController

	def create

		conn = Faraday.new(:url => 'https://api.typeform.io') do |faraday|
		  			faraday.request  :url_encoded             # form-encode POST params
		  			faraday.response :logger                  # log requests to STDOUT
		  			faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
				end

		puts "----XXXXX------XXXXX----"
		puts form_params
		puts "----XXXXX------XXXXX----"
		images = form_params["images"]

		images_typeform_ids = []


		images.each do |image|
			img = Cloudinary::Uploader.upload(image)

			response = conn.post do |req|
			  req.url '/v0.3/images', url: img["url"]
			  req.headers['X-API-TOKEN'] = 'b5ce1b063bedf822ffc6668a0ad5d50a'
			end
			response = JSON.parse response.body
			images_typeform_ids << response["id"]
		end

		debugger
		field = {:type => "picture_choice", :question => form_params["question"], :choices => []}

		images_typeform_ids.each do |id|
			field[:choices] << {:image_id => id.to_s, :label => ""}
		end

		response = conn.post do |req|
		  req.url '/v0.3/forms' 
		  req.headers['X-API-TOKEN'] = 'b5ce1b063bedf822ffc6668a0ad5d50a'
		  req.headers['Content-Type'] = 'application/json'
		  req.body = {:title => "Pickalo", :fields => [field]}.to_json
		end

		response = JSON.parse response.body

		render json: {link: response["links"].last}, status: 201

	end

	private
	def form_params
		params.require("form")
	end
end
