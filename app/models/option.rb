class Option < ActiveRecord::Base
	belongs_to :form

	def votes
		Answer.where(option_id: id).count
	end
end
