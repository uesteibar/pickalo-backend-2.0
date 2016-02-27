class Form < ActiveRecord::Base
	has_many :options
	has_many :answers

	validates_presence_of 	:typeform_id, :typeform_url, :question
	validates_uniqueness_of :typeform_id, :typeform_url

	def results
		options.map do |option|
			{
				option: option.label,
				votes: option.votes
			}
		end.sort_by { |result| -result[:votes] }
	end
end
