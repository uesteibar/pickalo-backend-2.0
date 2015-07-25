class AnswersController < ApplicationController
  def create
    form = Form.find_by(typeform_id: params['id'])
    if form
      option = form.options.find_by(typeform_id: params['answers'].first['data']['value']['label'])
      debugger
      form.answers.create(option_id: option.id)
    end
    render status: 200, body: 'good!'
  end
end
