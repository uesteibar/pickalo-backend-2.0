class Form < ActiveRecord::Base
	has_many :options
	has_many :answers

end
