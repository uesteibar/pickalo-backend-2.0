class AnswersController < ApplicationController
  def create
    form = Form.find_by(typeform_id: params["uid"])
    if form
      option = form.options.find_by(label: params["answers"].first["value"]["label"])
      form.answers.create(option_id: option.id)
    end

    render status: 200, body: "good!"
  end
end
