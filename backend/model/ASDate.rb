require 'timetwister'

class ASDate < Sequel::Model(:date)
  include ASModel
  corresponds_to JSONModel(:date)

  set_model_scope :global

  def populate(asdate, ttdate)
    asdate.json_schema_version = json_schema_version
    asdate.resource_id = resource_id
    asdate.label = label

    asdate.expression = ttdate[:original_string]
    asdate.begin = ttdate[:date_start] if ttdate[:date_start]
    asdate.end = ttdate[:date_end] if ttdate[:date_end]
    asdate.certainty = ttdate[:certainty] if ttdate[:certainty]
    asdate.date_type = ttdate[:inclusive_range] ? 'inclusive' : 'single'

    # default to ce/gregorian because why not
    asdate.calendar = 'gregorian' unless ttdate[:calendar]
    asdate.era = 'ce' unless ttdate[:era]

    return asdate
  end

  def before_save
 	  # if there are no normalized values, draw seven
	  if (!self.begin && !self.end) && self.expression

  		# parse date
    	parsed_dates = Timetwister.parse(self.expression)

    	# store the parsed values for first date if we were able to parse
      populate(self, parsed_dates.first)

      parsed_dates.drop(1).each do |ttdate|
        date = ASDate.new
        populate(date, ttdate)
        date.save
      end
    end

    super
  end
end
