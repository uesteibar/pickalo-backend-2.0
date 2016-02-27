module ApiPresenters
  class Form
    attr_reader :form

    def initialize(form)
      @form = form
    end

    def as_json
      {
        form: {
          id: form.id,
          question: form.question,
          link: form.typeform_url,
        },
        answers: form.results
      }.to_json
    end
  end
end
