require 'timetwister'

class ASDate < Sequel::Model(:date)
  include ASModel
  corresponds_to JSONModel(:date)

  set_model_scope :global

  def before_save
  	# if there are no normalized values, draw seven
	if (!self.begin && !self.end) && self.expression

		# parse date
    	parsed_date = Timetwister.parse(self.expression)

    	# store the parsed values if we were able to parse
        self.begin = parsed_date[0][:date_start] if parsed_date[0][:date_start]
    	self.end = parsed_date[0][:date_end] if parsed_date[0][:date_end]
    end
    super
  end
end