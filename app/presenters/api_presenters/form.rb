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
          created_at: form.created_at
        },
        answers: form.results,
        total_votes: form.answers.count
      }.to_json
    end
  end
end
