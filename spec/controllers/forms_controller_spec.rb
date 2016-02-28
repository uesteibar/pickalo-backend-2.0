require "rails_helper"

RSpec.describe FormsController, type: :controller do
  describe "GET #index" do
    before (:each) do
      @form_one = Form.create(typeform_id: "ab44c7", typeform_url: "https://forms.typeform.io/to/ab44c7", question: "where for dinner?")
      @form_two = Form.create(typeform_id: "ab48c0", typeform_url: "https://forms.typeform.io/to/ab48c0", question: "where for lunch?")
      @form_ids = [@form_one.id, @form_two.id]
    end

    it "gets the requested forms" do
      get :index, ids: @form_ids

      parsed_forms = JSON.parse response.body

      expect(parsed_forms.size).to eq(@form_ids.size)
    end
  end

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
    end
  end
end
