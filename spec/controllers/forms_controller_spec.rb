require "rails_helper"

RSpec.describe FormsController, type: :controller do

  describe "GET #show" do
    before (:each) do
      @form = Form.create(typeform_id: "ab44c7", typeform_url: "https://forms.typeform.io/to/ab44c7", question: "where for dinner?")
      @form.options.create(label: "hokaba")
      @form.options.create(label: "arzak")
    end

    it "shows the requested form" do
      get :show, id: @form.id

      parsed_form = JSON.parse(response.body)["form"]

      expect(parsed_form["id"]).to eq @form.id
    end
  end

  describe "POST #create" do
    before (:each) do
      @typeform_form_stub = {
        "id" => "ab44c7",
        "_links" => [
          { "href" => nil },
          { "href" => "https://forms.typeform.io/to/ab44c7" },
        ],
      }

      allow_any_instance_of(TypeformService).to receive(:create_form).and_return(@typeform_form_stub)
    end

    it "creates a new form" do
      form_params = { question: "where for dinner?", options: ["chinese", "bulli"] }

      expect do
        post :create, form: form_params
      end.to change(Form.all, :count).by(1)

      parsed_form = JSON.parse(response.body)["form"]

      expect(parsed_form["id"]).not_to be_falsy
      expect(parsed_form["link"]).to eq @typeform_form_stub["_links"].second["href"]
    end
  end
end
