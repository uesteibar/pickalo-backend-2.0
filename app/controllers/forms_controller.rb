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

  def winner
    answers_count = Form.find(params[:id]).answers.group(:option_id).count
    sorted_answers = answers_count.sort do |(id_a, count_a), (id_b, count_b)|
      count_b <=> count_a
    end
    option_id = sorted_answers.first[0]
    count = sorted_answers.first[1]
    result = Option.find(option_id).attributes.merge({votes: count})
    debugger
    render json: result, status: 200
  end

  private

  def form_params
    params.require('form')
  end
end
