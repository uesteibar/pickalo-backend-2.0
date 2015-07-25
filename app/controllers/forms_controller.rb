class FormsController < ApplicationController
  def create
    image_urls = CloudinaryAdapter.new(form_params['images']).get_urls

		typeform = Typeform.new(form_params['question'], image_urls)
    response = typeform.create_form

    form = Form.create(typeform_id: response['id'], typeform_url: response['links'].last['href'])

    response['fields'].first['choices'].each do |choice|
      form.options.create(image_url: choice[:image_url], typeform_id: choice['image_id'])
    end

    render json: { link: response['links'].last }, status: 201
  end

  private

  def form_params
    params.require('form')
  end
end
