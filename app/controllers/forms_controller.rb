class FormsController < ApplicationController

	def create

		conn = Faraday.new(:url => 'https://api.typeform.io/v0.3/') do |faraday|
		  			faraday.request  :url_encoded             # form-encode POST params
		  			faraday.response :logger                  # log requests to STDOUT
		  			faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
				end

		images = params[:images]

		puts params



		images_typeform_ids = []

		puts images.inspect

		images.each do |image|
			img = Cloudinary::Uploader.upload(image["imageUrl"])
			obj = {:url=> img["url"]}
			response = conn.get "/images/#{obj.to_json}"
			images_typeform_ids << response.body["id"]
		end

		puts images_typeform_ids

	end

	private
	def form_params
		params.require(:form).permit(:question)
	end
end
