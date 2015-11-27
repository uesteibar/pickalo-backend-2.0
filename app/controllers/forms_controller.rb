class FormsController < ApplicationController
  def create
    typeform_form = TypeformService.new.create_form question: form_params[:question], options: form_params[:options]
    form = Form.create typeform_id: typeform_form["id"], typeform_url: typeform_form["_links"].second["href"]
    options.each { |o| form.options.create(label: o) }
    render status: 201, json: { form: { link: form.typeform_url } }
  end

  private

  def form_params
    params.require :question, :options
  end
end
