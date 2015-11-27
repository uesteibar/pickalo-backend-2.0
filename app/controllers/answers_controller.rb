class AnswersController < ApplicationController
  def create
    form = Form.find_by(typeform_id: params['id'])
    if form
      option = form.options.find_by(typeform_id: params['answers'].first['data']['value']['label'])
      # save answer
    end
    render status: 200, body: 'good!'
  end
end
