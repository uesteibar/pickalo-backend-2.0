require "rails_helper"

RSpec.describe Form, type: :model do
  before(:each) do
    @form_params = {
      typeform_id: "ab44c7",
      typeform_url: "https://forms.typeform.io/to/ab44c7",
      question: "where for dinner?"
    }
  end

  describe "#create" do
    it "creates a form when all params are given" do
      expect do
        Form.create(@form_params)
      end.to change(Form.all, :count).by 1

      expect(Form.last.id).not_to be_falsy
      expect(Form.last.typeform_id).to eq @form_params[:typeform_id]
    end

    it "does not create a form when typeform_id is missing" do
      @form_params[:typeform_id] = nil

      expect do
        Form.create(@form_params)
      end.to change(Form.all, :count).by 0
    end

    it "does not create a form when typeform_url is missing" do
      @form_params[:typeform_url] = nil

      expect do
        Form.create(@form_params)
      end.to change(Form.all, :count).by 0
    end

    it "does not create a form when question is missing" do
      @form_params[:question] = nil

      expect do
        Form.create(@form_params)
      end.to change(Form.all, :count).by 0
    end
  end
end
