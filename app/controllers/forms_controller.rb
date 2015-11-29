class FormsController < ApplicationController
  def show
    form = Form.find params[:id]
    render status: 200, body: ApiPresenters::Form.new(form).as_json
  end

  def create
    typeform_form = TypeformService.new.create_form question: form_params[:question], options: form_params[:options]

    form = Form.create question: form_params[:question], typeform_id: typeform_form["id"], typeform_url: typeform_form["_links"].second["href"]

    form_params[:options].each { |o| form.options.create(label: o) }

    render status: 201, json: { form: { id: form.id, link: form.typeform_url } }
  end

  private

  def form_params
    params.require(:form).permit(:question, options: [])
  end
end
