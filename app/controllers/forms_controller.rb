class FormsController < ApplicationController
  def create
    image_urls = CloudinaryAdapter.new(form_params['images']).get_urls

		response = Typeform.new(form_params['question'], image_urls).create_form
    render json: { link: response['links'].last }, status: 201
  end

  private

  def form_params
    params.require('form')
  end
end
