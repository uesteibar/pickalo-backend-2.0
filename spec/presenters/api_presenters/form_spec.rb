require "rails_helper"

RSpec.describe Form, type: :model do

  describe "#as_json" do
    before(:each) do
      form_params = {
        typeform_id: "ab44c7",
        typeform_url: "https://forms.typeform.io/to/ab44c7",
        question: "where for dinner?"
      }

      @form = Form.create(form_params)
      @form.options.create(label: "home")
      @form.options.create(label: "arzak")

      @subject = ApiPresenters::Form.new @form
    end

    it "retuns the correct form information" do
      form_as_json = JSON.parse(@subject.as_json)["form"]

      expect(form_as_json["id"]).to eq @form.id
    end

    it "retuns the correct options" do
      options_as_json = JSON.parse(@subject.as_json)["options"]

      expect(options_as_json.size).to eq @form.options.count
      expect(options_as_json.first).to eq @form.options.first.label
      expect(options_as_json.second).to eq @form.options.second.label
    end
  end
end
