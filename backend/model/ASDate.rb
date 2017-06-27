require 'timetwister'

class ASDate < Sequel::Model(:date)
  include ASModel
  corresponds_to JSONModel(:date)

  set_model_scope :global

  # Sequel FKey fields that should just be copied from initial date if present
  @@association_fields = %w|accession_id
                            deaccession_id
                            archival_object_id
                            resource_id
                            event_id
                            digital_object_id
                            digital_object_component_id
                            related_agents_rlshp_id
                            agent_person_id
                            agent_family_id
                            agent_corporate_entity_id
                            agent_software_id
                            name_person_id
                            name_family_id
                            name_corporate_entity_id
                            name_software_id
                            date_type_id
                            label_id|


  def populate(asdate, ttdate, dtype)
    asdate.json_schema_version = self.json_schema_version

    @@association_fields.each do |field|
      asdate.send(field + '=', self.send(field)) if self.send(field)
    end

    asdate.expression = ttdate[:original_string]
    asdate.begin = ttdate[:date_start] if ttdate[:date_start]
    asdate.end = ttdate[:date_end] if ttdate[:date_end]
    asdate.certainty = ttdate[:certainty] if ttdate[:certainty]
    if dtype != 'bulk'
      asdate.date_type = ttdate[:inclusive_range] ? 'inclusive' : 'single'
    end

    # default to ce/gregorian because why not
    asdate.calendar = 'gregorian' unless ttdate[:calendar] || calendar
    asdate.era = 'ce' unless ttdate[:era] || era

    return asdate
  end

  def before_save
 	  # if there are no normalized values, draw seven
	  if (!self.begin && !self.end) && self.expression

  		# parse date
    	parsed_dates = Timetwister.parse(self.expression)

      # store pre-parse date_type
      # otherwise, any range will annihilate bulk type
      dtype = self.date_type

    	# store the parsed values for first date if we were able to parse
      populate(self, parsed_dates.first, dtype)

      parsed_dates.drop(1).each do |ttdate|
        date = ASDate.new
        populate(date, ttdate, dtype)
        date.save
      end
    end

    super
  end
end
